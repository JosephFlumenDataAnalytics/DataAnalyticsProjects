-- ============================================================================
-- DASHBOARD: Inventory
-- Source tables: ecommerce.inventory_snapshots, ecommerce.products, ecommerce.orders
-- Field filter: "snapshot_date" mapped to ecommerce.inventory_snapshots.snapshot_date
--   - Trend cards -> filter widget type: Month and Year
-- ============================================================================


-- ----------------------------------------------------------------------------
-- 1. Avg Inventory Value  (KPI, Trend)
--    Excludes the first 2 months of data, which start artificially high
--    as initial stock has not yet drawn down to a steady-state level.
-- ----------------------------------------------------------------------------
SELECT
  DATE_TRUNC('month', snapshot_date) AS "Month",
  ROUND(AVG(daily_value)::numeric, 2) AS "Avg Inventory Value"
FROM (
  SELECT
    snapshot_date,
    SUM(inventory_value) AS daily_value
  FROM ecommerce.inventory_snapshots
  WHERE snapshot_date >= (
    SELECT MIN(snapshot_date) + INTERVAL '2 months'
    FROM ecommerce.inventory_snapshots
  )
  [[AND {{snapshot_date}}]]
  GROUP BY snapshot_date
) daily
GROUP BY 1
ORDER BY 1;


-- ----------------------------------------------------------------------------
-- 2. Current Stock Level by Category  (Bar)
--    Always pulls the most recent snapshot date; no date filter needed.
-- ----------------------------------------------------------------------------
SELECT
  p.category AS "Category",
  SUM(i.units_on_hand) AS "Units On Hand",
  ROUND(SUM(i.inventory_value)::numeric, 2) AS "Inventory Value"
FROM ecommerce.inventory_snapshots i
JOIN ecommerce.products p ON p.id = i.product_id
WHERE i.snapshot_date = (
  SELECT MAX(snapshot_date)
  FROM ecommerce.inventory_snapshots
)
GROUP BY p.category
ORDER BY "Inventory Value" DESC;


-- ----------------------------------------------------------------------------
-- 3. Inventory Turnover by Month  (Line)
--    Raw monthly turns = that month's COGS / that month's average inventory
--    value. This is the more honest read month to month; it does NOT
--    annualize (multiplying by 12 would extrapolate seasonal months like
--    November into a misleading annual rate).
--    No date filter: COGS comes from orders, inventory value comes from
--    snapshots, and the two tables don't share a single filterable column.
-- ----------------------------------------------------------------------------
WITH monthly_cogs AS (
  SELECT
    DATE_TRUNC('month', ordered_at) AS month,
    SUM(order_cost) AS cogs
  FROM ecommerce.orders
  WHERE status <> 'cancelled'
  GROUP BY 1
),
monthly_inv AS (
  SELECT
    DATE_TRUNC('month', snapshot_date) AS month,
    AVG(daily_value) AS avg_inv_value
  FROM (
    SELECT
      snapshot_date,
      SUM(inventory_value) AS daily_value
    FROM ecommerce.inventory_snapshots
    GROUP BY snapshot_date
  ) daily
  GROUP BY 1
)
SELECT
  mc.month AS "Month",
  ROUND((mc.cogs / NULLIF(mi.avg_inv_value, 0))::numeric, 2) AS "Monthly Inventory Turns"
FROM monthly_cogs mc
LEFT JOIN monthly_inv mi ON mi.month = mc.month
ORDER BY mc.month;


-- ----------------------------------------------------------------------------
-- 3b. Alternate: Rolling 12-Month Inventory Turns
--     True annualized rate without seasonal distortion. First 11 months
--     of the series will be based on a partial window and read low.
-- ----------------------------------------------------------------------------
WITH monthly_cogs AS (
  SELECT
    DATE_TRUNC('month', ordered_at) AS month,
    SUM(order_cost) AS cogs
  FROM ecommerce.orders
  WHERE status <> 'cancelled'
  GROUP BY 1
),
monthly_inv AS (
  SELECT
    DATE_TRUNC('month', snapshot_date) AS month,
    AVG(daily_value) AS avg_inv_value
  FROM (
    SELECT
      snapshot_date,
      SUM(inventory_value) AS daily_value
    FROM ecommerce.inventory_snapshots
    GROUP BY snapshot_date
  ) daily
  GROUP BY 1
),
joined AS (
  SELECT mc.month, mc.cogs, mi.avg_inv_value
  FROM monthly_cogs mc
  LEFT JOIN monthly_inv mi ON mi.month = mc.month
)
SELECT
  month AS "Month",
  ROUND((
    SUM(cogs) OVER (ORDER BY month ROWS BETWEEN 11 PRECEDING AND CURRENT ROW)
    / NULLIF(AVG(avg_inv_value) OVER (ORDER BY month ROWS BETWEEN 11 PRECEDING AND CURRENT ROW), 0)
  )::numeric, 2) AS "Inventory Turns Rolling 12M"
FROM joined
ORDER BY month;
