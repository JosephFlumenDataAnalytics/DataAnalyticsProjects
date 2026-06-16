-- ============================================================================
-- DASHBOARD: Revenue & Sales
-- Source tables: ecommerce.orders, ecommerce.customers, ecommerce.order_items,
--                ecommerce.products
-- Field filter: "order_date" mapped to either ecommerce.orders.ordered_at or
--               ecommerce.order_items.ordered_at, as noted per card.
--   - Filter widget type: Date Range
-- ============================================================================


-- ----------------------------------------------------------------------------
-- 1. Revenue by Customer Segment over Time  (Line, one series per segment)
-- Field filter mapped to: ecommerce.orders.ordered_at
-- ----------------------------------------------------------------------------
SELECT
  DATE_TRUNC('month', o.ordered_at) AS "Month",
  c.segment AS "Segment",
  ROUND(SUM(o.order_total)::numeric, 2) AS "Revenue"
FROM ecommerce.orders o
JOIN ecommerce.customers c ON c.id = o.customer_id
WHERE o.status <> 'cancelled'
[[AND {{order_date}}]]
GROUP BY 1, 2
ORDER BY 1, 2;


-- ----------------------------------------------------------------------------
-- 2. Revenue by Acquisition Channel  (Bar)
-- Field filter mapped to: ecommerce.orders.ordered_at
-- ----------------------------------------------------------------------------
SELECT
  c.acquisition_channel AS "Acquisition Channel",
  ROUND(SUM(o.order_total)::numeric, 2) AS "Revenue",
  COUNT(DISTINCT o.customer_id) AS "Customers",
  ROUND(AVG(o.order_total)::numeric, 2) AS "Avg Order Value"
FROM ecommerce.orders o
JOIN ecommerce.customers c ON c.id = o.customer_id
WHERE o.status <> 'cancelled'
[[AND {{order_date}}]]
GROUP BY c.acquisition_channel
ORDER BY "Revenue" DESC;


-- ----------------------------------------------------------------------------
-- 3. Average Order Value over Time  (Line)
-- Field filter mapped to: ecommerce.orders.ordered_at
-- ----------------------------------------------------------------------------
SELECT
  DATE_TRUNC('month', ordered_at) AS "Month",
  ROUND(AVG(order_total)::numeric, 2) AS "Avg Order Value"
FROM ecommerce.orders
WHERE status <> 'cancelled'
[[AND {{order_date}}]]
GROUP BY 1
ORDER BY 1;


-- ----------------------------------------------------------------------------
-- 4. Discount Impact by Category  (Bar, optionally combo w/ Discount Rate
--    as a line on a secondary axis)
-- Field filter mapped to: ecommerce.order_items.ordered_at
-- ----------------------------------------------------------------------------
SELECT
  p.category AS "Category",
  ROUND(SUM(oi.discount)::numeric, 2) AS "Total Discounts",
  ROUND((100.0 * SUM(oi.discount)
    / NULLIF(SUM(oi.subtotal + oi.discount), 0))::numeric, 1) AS "Discount Rate"
FROM ecommerce.order_items oi
JOIN ecommerce.products p ON p.id = oi.product_id
JOIN ecommerce.orders o ON o.id = oi.order_id
WHERE o.status <> 'cancelled'
[[AND {{order_date}}]]
GROUP BY p.category
ORDER BY "Total Discounts" DESC;
