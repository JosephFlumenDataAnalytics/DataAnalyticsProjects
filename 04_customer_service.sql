-- ============================================================================
-- DASHBOARD: Customer Service Rating
-- Source table: ecommerce.support_interactions (joined to ecommerce.employees)
-- Field filter: "interaction_date" mapped to ecommerce.support_interactions.opened_at
--   - Trend cards -> filter widget type: Month and Year
--   - Bar charts   -> filter widget type: Date Range
-- ============================================================================


-- ----------------------------------------------------------------------------
-- 1. Service Rating Leaderboard  (Bar)
-- ----------------------------------------------------------------------------
SELECT
  e.full_name AS "Employee",
  COUNT(*) AS "Tickets",
  ROUND(AVG(s.service_rating)::numeric, 2) AS "Avg Rating",
  ROUND(AVG(s.resolution_minutes)::numeric, 0) AS "Avg Resolution Minutes"
FROM ecommerce.support_interactions s
JOIN ecommerce.employees e ON e.id = s.employee_id
[[WHERE {{interaction_date}}]]
GROUP BY e.full_name
ORDER BY "Avg Rating" DESC;


-- ----------------------------------------------------------------------------
-- 2. Avg Service Rating over Time  (KPI, Trend)
-- ----------------------------------------------------------------------------
SELECT
  DATE_TRUNC('month', s.opened_at) AS "Month",
  ROUND(AVG(s.service_rating)::numeric, 2) AS "Avg Service Rating"
FROM ecommerce.support_interactions s
[[WHERE {{interaction_date}}]]
GROUP BY 1
ORDER BY 1;


-- ----------------------------------------------------------------------------
-- 3. Ticket Volume over Time  (Bar)
-- ----------------------------------------------------------------------------
SELECT
  DATE_TRUNC('month', opened_at) AS "Month",
  COUNT(*) AS "Tickets"
FROM ecommerce.support_interactions
[[WHERE {{interaction_date}}]]
GROUP BY 1
ORDER BY 1;


-- ----------------------------------------------------------------------------
-- 4. Tickets by Issue Category  (Bar, optionally combo w/ Avg Rating as line)
-- ----------------------------------------------------------------------------
SELECT
  issue_category AS "Issue Category",
  COUNT(*) AS "Tickets",
  ROUND(AVG(service_rating)::numeric, 2) AS "Avg Rating"
FROM ecommerce.support_interactions
[[WHERE {{interaction_date}}]]
GROUP BY issue_category
ORDER BY "Tickets" DESC;


-- ----------------------------------------------------------------------------
-- 5. Tickets by Channel  (Bar, optionally combo w/ Avg Rating as line)
-- ----------------------------------------------------------------------------
SELECT
  channel AS "Channel",
  COUNT(*) AS "Tickets",
  ROUND(AVG(service_rating)::numeric, 2) AS "Avg Rating",
  ROUND(AVG(resolution_minutes)::numeric, 0) AS "Avg Resolution Minutes"
FROM ecommerce.support_interactions
[[WHERE {{interaction_date}}]]
GROUP BY channel
ORDER BY "Tickets" DESC;
