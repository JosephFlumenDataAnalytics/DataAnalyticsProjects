-- ============================================================================
-- DASHBOARD: Order Fulfillment
-- Source table: ecommerce.orders
-- Field filter: "order_date" mapped to ecommerce.orders.ordered_at
--   - Filter widget type: Date Range
-- ============================================================================


-- ----------------------------------------------------------------------------
-- 1. On-Time Delivery Rate over Time  (Line)
-- ----------------------------------------------------------------------------
SELECT
  DATE_TRUNC('month', ordered_at) AS "Month",
  ROUND((100.0 * COUNT(*) FILTER (WHERE delivered_at <= promised_at)
    / NULLIF(COUNT(*), 0))::numeric, 1) AS "On Time Delivery Rate"
FROM ecommerce.orders
WHERE status = 'delivered'
[[AND {{order_date}}]]
GROUP BY 1
ORDER BY 1;


-- ----------------------------------------------------------------------------
-- 2. Avg Days to Deliver by Ship Mode  (Bar, optionally combo w/ On Time Rate
--    as a line on a secondary axis)
-- ----------------------------------------------------------------------------
SELECT
  ship_mode AS "Ship Mode",
  COUNT(*) AS "Orders",
  ROUND(AVG(EXTRACT(EPOCH FROM (delivered_at - ordered_at)) / 86400)::numeric, 1)
    AS "Avg Days To Deliver",
  ROUND((100.0 * COUNT(*) FILTER (WHERE delivered_at <= promised_at)
    / NULLIF(COUNT(*), 0))::numeric, 1) AS "On Time Rate"
FROM ecommerce.orders
WHERE status = 'delivered'
[[AND {{order_date}}]]
GROUP BY ship_mode
ORDER BY "Avg Days To Deliver" ASC;


-- ----------------------------------------------------------------------------
-- 3. Order Status Breakdown  (Bar)
-- ----------------------------------------------------------------------------
SELECT
  status AS "Status",
  COUNT(*) AS "Orders",
  ROUND((100.0 * COUNT(*) / NULLIF(SUM(COUNT(*)) OVER (), 0))::numeric, 1) AS "Pct Of Orders"
FROM ecommerce.orders
[[WHERE {{order_date}}]]
GROUP BY status
ORDER BY "Orders" DESC;


-- ----------------------------------------------------------------------------
-- 4. On-Time Delivery Rate by Region  (Bar)
-- ----------------------------------------------------------------------------
SELECT
  region AS "Region",
  COUNT(*) AS "Orders",
  ROUND((100.0 * COUNT(*) FILTER (WHERE delivered_at <= promised_at)
    / NULLIF(COUNT(*), 0))::numeric, 1) AS "On Time Rate",
  ROUND(AVG(EXTRACT(EPOCH FROM (delivered_at - ordered_at)) / 86400)::numeric, 1)
    AS "Avg Days To Deliver"
FROM ecommerce.orders
WHERE status = 'delivered'
[[AND {{order_date}}]]
GROUP BY region
ORDER BY "On Time Rate" DESC;


-- ----------------------------------------------------------------------------
-- 5. Monthly Order Volume  (Stacked Bar)
-- ----------------------------------------------------------------------------
SELECT
  DATE_TRUNC('month', ordered_at) AS "Month",
  COUNT(*) AS "Orders",
  COUNT(*) FILTER (WHERE status = 'delivered') AS "Delivered",
  COUNT(*) FILTER (WHERE status = 'cancelled') AS "Cancelled",
  COUNT(*) FILTER (WHERE status = 'returned') AS "Returned"
FROM ecommerce.orders
[[WHERE {{order_date}}]]
GROUP BY 1
ORDER BY 1;
