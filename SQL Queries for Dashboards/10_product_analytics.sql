-- ============================================================================
-- DASHBOARD: Product Analytics
-- Source tables: ecommerce.order_items, ecommerce.products, ecommerce.orders
-- Field filter: "order_date" mapped to ecommerce.order_items.ordered_at
--   - Filter widget type: Date Range
-- ============================================================================


-- ----------------------------------------------------------------------------
-- 1. Top Products by Revenue  (Bar, top 20)
--    "Category" column can be used to color bars by category in viz settings.
-- ----------------------------------------------------------------------------
SELECT
  p.name AS "Product",
  p.category AS "Category",
  ROUND(SUM(oi.subtotal)::numeric, 2) AS "Revenue",
  SUM(oi.quantity) AS "Units Sold"
FROM ecommerce.order_items oi
JOIN ecommerce.products p ON p.id = oi.product_id
JOIN ecommerce.orders o ON o.id = oi.order_id
WHERE o.status <> 'cancelled'
[[AND {{order_date}}]]
GROUP BY p.name, p.category
ORDER BY "Revenue" DESC
LIMIT 20;


-- ----------------------------------------------------------------------------
-- 2. Revenue Breakdown: COGS vs Gross Profit by Category  (Stacked Bar)
--    COGS and Gross Profit are stacked so the full bar height = revenue,
--    with COGS visually "eating into" the bar. Set COGS to red and
--    Gross Profit to green in series colors. "Gross Margin %" is included
--    for the tooltip only -- leave it untoggled as a series.
-- ----------------------------------------------------------------------------
SELECT
  p.category AS "Category",
  ROUND(SUM(oi.cost_total)::numeric, 2) AS "COGS",
  ROUND((SUM(oi.subtotal) - SUM(oi.cost_total))::numeric, 2) AS "Gross Profit",
  ROUND((100.0 * (SUM(oi.subtotal) - SUM(oi.cost_total))
    / NULLIF(SUM(oi.subtotal), 0))::numeric, 1) AS "Gross Margin %"
FROM ecommerce.order_items oi
JOIN ecommerce.products p ON p.id = oi.product_id
JOIN ecommerce.orders o ON o.id = oi.order_id
WHERE o.status <> 'cancelled'
[[AND {{order_date}}]]
GROUP BY p.category
ORDER BY SUM(oi.subtotal) DESC;


-- ----------------------------------------------------------------------------
-- 3. Return Rate by Product Category  (Bar)
-- ----------------------------------------------------------------------------
SELECT
  p.category AS "Category",
  COUNT(DISTINCT o.id) AS "Orders",
  COUNT(DISTINCT o.id) FILTER (WHERE o.status = 'returned') AS "Returns",
  ROUND((100.0 * COUNT(DISTINCT o.id) FILTER (WHERE o.status = 'returned')
    / NULLIF(COUNT(DISTINCT o.id), 0))::numeric, 1) AS "Return Rate"
FROM ecommerce.order_items oi
JOIN ecommerce.products p ON p.id = oi.product_id
JOIN ecommerce.orders o ON o.id = oi.order_id
[[WHERE {{order_date}}]]
GROUP BY p.category
ORDER BY "Return Rate" DESC;


-- ----------------------------------------------------------------------------
-- 4. Revenue by Category over Time  (Stacked Bar)
-- ----------------------------------------------------------------------------
SELECT
  DATE_TRUNC('month', o.ordered_at) AS "Month",
  p.category AS "Category",
  ROUND(SUM(oi.subtotal)::numeric, 2) AS "Revenue"
FROM ecommerce.order_items oi
JOIN ecommerce.products p ON p.id = oi.product_id
JOIN ecommerce.orders o ON o.id = oi.order_id
WHERE o.status <> 'cancelled'
[[AND {{order_date}}]]
GROUP BY 1, 2
ORDER BY 1, 2;
