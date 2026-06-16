-- ============================================================================
-- DASHBOARD: Customer Retention
-- Source tables: ecommerce.orders, ecommerce.customers
-- NOTE: These queries intentionally do NOT take a date-range field filter.
--       Filtering the order history would distort each customer's first-order
--       date, breaking the new-vs-returning classification. The Trend
--       visualization handles month-over-month comparison from the full grouped
--       result set without needing a filter.
-- ============================================================================


-- ----------------------------------------------------------------------------
-- 1. Returning Customer Rate  (KPI, Trend)
-- ----------------------------------------------------------------------------
WITH customer_order_months AS (
  SELECT
    DATE_TRUNC('month', ordered_at) AS month,
    customer_id,
    MIN(ordered_at) OVER (PARTITION BY customer_id) AS first_order_at
  FROM ecommerce.orders
  WHERE status <> 'cancelled'
)
SELECT
  month AS "Month",
  ROUND((100.0 *
    COUNT(DISTINCT CASE
      WHEN DATE_TRUNC('month', first_order_at) < month
      THEN customer_id
    END)
    / NULLIF(COUNT(DISTINCT customer_id), 0)
  )::numeric, 1) AS "Returning Customer Pct"
FROM customer_order_months
GROUP BY 1
ORDER BY 1;


-- ----------------------------------------------------------------------------
-- 2. New vs Returning Customers by Month  (Stacked Bar)
-- ----------------------------------------------------------------------------
WITH customer_order_months AS (
  SELECT
    DATE_TRUNC('month', ordered_at) AS month,
    customer_id,
    MIN(ordered_at) OVER (PARTITION BY customer_id) AS first_order_at
  FROM ecommerce.orders
  WHERE status <> 'cancelled'
)
SELECT
  month AS "Month",
  COUNT(DISTINCT CASE
    WHEN DATE_TRUNC('month', first_order_at) = month
    THEN customer_id
  END) AS "New Customers",
  COUNT(DISTINCT CASE
    WHEN DATE_TRUNC('month', first_order_at) < month
    THEN customer_id
  END) AS "Returning Customers"
FROM customer_order_months
GROUP BY 1
ORDER BY 1;


-- ----------------------------------------------------------------------------
-- 3. Cohort Size vs Retention Rate  (Combo: Bar = cohort size, Line = retention %)
--    First and last cohort months are excluded since they lack a full
--    observation window (most recent cohort hasn't had time to return;
--    earliest cohort predates the data set's visibility into prior history).
-- ----------------------------------------------------------------------------
WITH first_orders AS (
  SELECT
    customer_id,
    DATE_TRUNC('month', MIN(ordered_at)) AS cohort_month
  FROM ecommerce.orders
  WHERE status <> 'cancelled'
  GROUP BY customer_id
),
cohort_activity AS (
  SELECT
    f.customer_id,
    f.cohort_month,
    COUNT(DISTINCT DATE_TRUNC('month', o.ordered_at)) AS active_months
  FROM ecommerce.orders o
  JOIN first_orders f ON f.customer_id = o.customer_id
  WHERE o.status <> 'cancelled'
  GROUP BY f.customer_id, f.cohort_month
),
cohort_stats AS (
  SELECT
    cohort_month,
    COUNT(*) AS cohort_size,
    ROUND((100.0 * COUNT(*) FILTER (WHERE active_months > 1)
      / NULLIF(COUNT(*), 0))::numeric, 1) AS retention_rate
  FROM cohort_activity
  GROUP BY cohort_month
)
SELECT
  TO_CHAR(cohort_month, 'YYYY-MM') AS "Cohort",
  cohort_size AS "Cohort Size",
  retention_rate AS "Retention Rate"
FROM cohort_stats
WHERE cohort_month > (SELECT MIN(cohort_month) FROM cohort_stats)
  AND cohort_month < (SELECT MAX(cohort_month) FROM cohort_stats)
ORDER BY cohort_month;


-- ----------------------------------------------------------------------------
-- 4. New Customer Acquisition by Month  (Bar)
-- Field filter: "signup_date" mapped to ecommerce.customers.signup_date
-- Filter widget type: Date Range
-- ----------------------------------------------------------------------------
SELECT
  DATE_TRUNC('month', signup_date) AS "Month",
  COUNT(*) AS "New Customers"
FROM ecommerce.customers
[[WHERE {{signup_date}}]]
GROUP BY 1
ORDER BY 1;


-- ----------------------------------------------------------------------------
-- Optional cohort retention heatmap (table form, not turned into a chart yet)
-- Pivot in Metabase: rows = Cohort, columns = Month Number, values = Retention Rate
-- ----------------------------------------------------------------------------
WITH first_orders AS (
  SELECT
    customer_id,
    DATE_TRUNC('month', MIN(ordered_at)) AS cohort_month
  FROM ecommerce.orders
  WHERE status <> 'cancelled'
  GROUP BY customer_id
),
cohort_sizes AS (
  SELECT cohort_month, COUNT(*) AS cohort_size
  FROM first_orders
  GROUP BY cohort_month
),
order_periods AS (
  SELECT
    f.customer_id,
    f.cohort_month,
    (EXTRACT(YEAR FROM AGE(
      DATE_TRUNC('month', o.ordered_at), f.cohort_month
    )) * 12 +
    EXTRACT(MONTH FROM AGE(
      DATE_TRUNC('month', o.ordered_at), f.cohort_month
    )))::int AS months_since_first
  FROM ecommerce.orders o
  JOIN first_orders f ON f.customer_id = o.customer_id
  WHERE o.status <> 'cancelled'
)
SELECT
  TO_CHAR(op.cohort_month, 'YYYY-MM') AS "Cohort",
  op.months_since_first AS "Month Number",
  cs.cohort_size AS "Cohort Size",
  COUNT(DISTINCT op.customer_id) AS "Active Customers",
  ROUND((100.0 * COUNT(DISTINCT op.customer_id) / cs.cohort_size)::numeric, 1) AS "Retention Rate"
FROM order_periods op
JOIN cohort_sizes cs ON cs.cohort_month = op.cohort_month
GROUP BY 1, 2, cs.cohort_size, op.cohort_month
ORDER BY op.cohort_month, op.months_since_first;
