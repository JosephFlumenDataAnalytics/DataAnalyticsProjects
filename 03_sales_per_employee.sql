-- ============================================================================
-- DASHBOARD: Sales per Employee
-- Source tables: ecommerce.orders, ecommerce.employees
-- Field filter: "order_date" mapped to ecommerce.orders.ordered_at
--   - Trend cards -> filter widget type: Month and Year
--   - Bar charts   -> filter widget type: Date Range
-- ============================================================================


-- ----------------------------------------------------------------------------
-- 1. Sales Leaderboard  (Bar)
-- ----------------------------------------------------------------------------
SELECT
  e.full_name AS "Employee",
  COUNT(DISTINCT o.id) AS "Orders",
  ROUND(SUM(o.order_total)::numeric, 2) AS "Revenue",
  ROUND(AVG(o.order_total)::numeric, 2) AS "Avg Order Value"
FROM ecommerce.orders o
JOIN ecommerce.employees e ON e.id = o.sales_employee_id
WHERE o.status <> 'cancelled'
[[AND {{order_date}}]]
GROUP BY e.full_name
ORDER BY "Revenue" DESC;


-- ----------------------------------------------------------------------------
-- 2. Avg Revenue per Employee by Month  (KPI, Trend)
--    Denominator = sales employees with at least one order that month.
-- ----------------------------------------------------------------------------
SELECT
  DATE_TRUNC('month', o.ordered_at) AS "Month",
  ROUND((SUM(o.order_total) / NULLIF(COUNT(DISTINCT o.sales_employee_id), 0))::numeric, 2)
    AS "Avg Revenue Per Employee"
FROM ecommerce.orders o
WHERE o.status <> 'cancelled'
[[AND {{order_date}}]]
GROUP BY 1
ORDER BY 1;


-- ----------------------------------------------------------------------------
-- 2b. Alternate version: divide by total active sales headcount
--     regardless of whether they had orders that month.
-- ----------------------------------------------------------------------------
SELECT
  DATE_TRUNC('month', o.ordered_at) AS "Month",
  ROUND((SUM(o.order_total) / (
    SELECT COUNT(*) FROM ecommerce.employees
    WHERE department = 'Sales' AND active = TRUE
  ))::numeric, 2) AS "Avg Revenue Per Employee"
FROM ecommerce.orders o
WHERE o.status <> 'cancelled'
[[AND {{order_date}}]]
GROUP BY 1
ORDER BY 1;
