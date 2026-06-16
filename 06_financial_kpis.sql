-- ============================================================================
-- DASHBOARD: Financial KPIs
-- Source tables: ecommerce.orders, ecommerce.operating_expenses
-- Field filters:
--   "order_date"     mapped to ecommerce.orders.ordered_at
--   "expense_month"  mapped to ecommerce.operating_expenses.expense_month
--   - All cards here are KPI Trend cards -> filter widget type: Month and Year
-- ============================================================================


-- ----------------------------------------------------------------------------
-- 1. Gross Margin %  (KPI, Trend)
-- ----------------------------------------------------------------------------
SELECT
  DATE_TRUNC('month', ordered_at) AS "Month",
  ROUND((100.0 * (SUM(order_total) - SUM(order_cost))
    / NULLIF(SUM(order_total), 0))::numeric, 1) AS "Gross Margin %"
FROM ecommerce.orders
WHERE status <> 'cancelled'
[[AND {{order_date}}]]
GROUP BY 1
ORDER BY 1;


-- ----------------------------------------------------------------------------
-- 2. Operating Expenses  (KPI, Trend)
-- ----------------------------------------------------------------------------
SELECT
  DATE_TRUNC('month', expense_month) AS "Month",
  ROUND(SUM(amount)::numeric, 2) AS "Operating Expenses"
FROM ecommerce.operating_expenses
[[WHERE {{expense_month}}]]
GROUP BY 1
ORDER BY 1;


-- ----------------------------------------------------------------------------
-- 3. Net Profit  (KPI, Trend)
--    Net Profit = Revenue - COGS - Operating Expenses
-- ----------------------------------------------------------------------------
WITH revenue AS (
  SELECT
    DATE_TRUNC('month', ordered_at) AS month,
    SUM(order_total) AS revenue,
    SUM(order_cost) AS cogs
  FROM ecommerce.orders
  WHERE status <> 'cancelled'
  [[AND {{order_date}}]]
  GROUP BY 1
),
opex AS (
  SELECT
    DATE_TRUNC('month', expense_month) AS month,
    SUM(amount) AS opex
  FROM ecommerce.operating_expenses
  GROUP BY 1
)
SELECT
  revenue.month AS "Month",
  ROUND((revenue.revenue - revenue.cogs - COALESCE(opex.opex, 0))::numeric, 2) AS "Net Profit"
FROM revenue
LEFT JOIN opex ON opex.month = revenue.month
ORDER BY revenue.month;


-- ----------------------------------------------------------------------------
-- 4. Cost of Goods Sold (COGS)  (KPI, Trend)
-- ----------------------------------------------------------------------------
SELECT
  DATE_TRUNC('month', ordered_at) AS "Month",
  ROUND(SUM(order_cost)::numeric, 2) AS "COGS"
FROM ecommerce.orders
WHERE status <> 'cancelled'
[[AND {{order_date}}]]
GROUP BY 1
ORDER BY 1;
