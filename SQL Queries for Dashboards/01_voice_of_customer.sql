-- ============================================================================
-- DASHBOARD: Voice of Customer
-- Covers: Customer Satisfaction (CSAT), Net Promoter Score (NPS), Feedback
-- Source table: ecommerce.surveys (joined to ecommerce.customers where noted)
-- Field filter: "survey_date" mapped to ecommerce.surveys.survey_date
--   - Trend cards   -> filter widget type: Month and Year
--   - Line/Bar/Table cards -> filter widget type: Date Range
-- ============================================================================


-- ----------------------------------------------------------------------------
-- 1. Avg CSAT  (KPI, Trend)
-- ----------------------------------------------------------------------------
SELECT
  DATE_TRUNC('month', survey_date) AS "Month",
  ROUND(AVG(csat_score)::numeric, 2) AS "Avg CSAT"
FROM ecommerce.surveys
WHERE csat_score IS NOT NULL
[[AND {{survey_date}}]]
GROUP BY 1
ORDER BY 1;


-- ----------------------------------------------------------------------------
-- 2. NPS Score  (KPI, Trend)
-- ----------------------------------------------------------------------------
SELECT
  DATE_TRUNC('month', survey_date) AS "Month",
  ROUND((AVG(CASE
    WHEN nps_score >= 9 THEN 1
    WHEN nps_score <= 6 THEN -1
    ELSE 0
  END) * 100)::numeric, 1) AS "NPS Score"
FROM ecommerce.surveys
WHERE nps_score IS NOT NULL
[[AND {{survey_date}}]]
GROUP BY 1
ORDER BY 1;


-- ----------------------------------------------------------------------------
-- 3. CSAT over time  (Line)
-- ----------------------------------------------------------------------------
SELECT
  DATE_TRUNC('month', survey_date) AS "Month",
  ROUND(AVG(csat_score)::numeric, 2) AS "Avg CSAT"
FROM ecommerce.surveys
WHERE csat_score IS NOT NULL
[[AND {{survey_date}}]]
GROUP BY 1
ORDER BY 1;


-- ----------------------------------------------------------------------------
-- 4. NPS over time  (Line)
-- ----------------------------------------------------------------------------
SELECT
  DATE_TRUNC('month', survey_date) AS "Month",
  ROUND((100.0 * (
      COUNT(*) FILTER (WHERE nps_score >= 9)
    - COUNT(*) FILTER (WHERE nps_score <= 6)
  ) / NULLIF(COUNT(*), 0))::numeric, 1) AS "NPS"
FROM ecommerce.surveys
WHERE nps_score IS NOT NULL
[[AND {{survey_date}}]]
GROUP BY 1
ORDER BY 1;


-- ----------------------------------------------------------------------------
-- 5. CSAT distribution  (Bar)
-- ----------------------------------------------------------------------------
SELECT
  csat_score AS "Score",
  COUNT(*) AS "Responses"
FROM ecommerce.surveys
WHERE csat_score IS NOT NULL
[[AND {{survey_date}}]]
GROUP BY 1
ORDER BY 1;


-- ----------------------------------------------------------------------------
-- 6. NPS breakdown  (Pie or Bar)
-- ----------------------------------------------------------------------------
SELECT
  nps_category AS "NPS Category",
  COUNT(*) AS "Count",
  ROUND((100.0 * COUNT(*) / NULLIF(SUM(COUNT(*)) OVER (), 0))::numeric, 1) AS "Pct"
FROM ecommerce.surveys
WHERE nps_score IS NOT NULL
[[AND {{survey_date}}]]
GROUP BY 1
ORDER BY CASE nps_category
  WHEN 'Promoter'  THEN 1
  WHEN 'Passive'   THEN 2
  WHEN 'Detractor' THEN 3
END;


-- ----------------------------------------------------------------------------
-- 7. CSAT by topic  (Bar)
-- ----------------------------------------------------------------------------
SELECT
  topic AS "Topic",
  ROUND(AVG(csat_score)::numeric, 2) AS "Avg CSAT",
  COUNT(*) AS "Responses"
FROM ecommerce.surveys
WHERE csat_score IS NOT NULL
  AND topic IS NOT NULL
[[AND {{survey_date}}]]
GROUP BY 1
ORDER BY "Avg CSAT" DESC;


-- ----------------------------------------------------------------------------
-- 8. Recent feedback  (Table)
-- ----------------------------------------------------------------------------
SELECT
  survey_date::date AS "Date",
  c.full_name AS "Customer",
  s.topic AS "Topic",
  s.csat_score AS "Customer Satisfaction Score",
  s.nps_category AS "Role",
  s.sentiment AS "Sentiment",
  s.comment_text AS "Feedback"
FROM ecommerce.surveys s
JOIN ecommerce.customers c ON c.id = s.customer_id
WHERE s.comment_text IS NOT NULL
  AND s.comment_text <> ''
[[AND {{survey_date}}]]
ORDER BY survey_date DESC
LIMIT 50;
