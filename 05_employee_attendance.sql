-- ============================================================================
-- DASHBOARD: Employee Attendance
-- Source table: ecommerce.employee_attendance (joined to ecommerce.employees)
-- Field filter: "work_date" mapped to ecommerce.employee_attendance.work_date
--   - Filter widget type: Date Range
-- ============================================================================


-- ----------------------------------------------------------------------------
-- 1. Attendance Rate by Employee  (Table, with conditional formatting:
--    green->red color scale on "Attendance Rate", sorted ascending)
-- ----------------------------------------------------------------------------
SELECT
  e.full_name AS "Employee",
  COUNT(*) AS "Scheduled Days",
  ROUND((100.0 * COUNT(*) FILTER (WHERE a.status IN ('Present', 'Remote'))
    / NULLIF(COUNT(*), 0))::numeric, 1) AS "Attendance Rate",
  COUNT(*) FILTER (WHERE a.status = 'Absent') AS "Absences",
  COUNT(*) FILTER (WHERE a.status = 'Late') AS "Late Days"
FROM ecommerce.employee_attendance a
JOIN ecommerce.employees e ON e.id = a.employee_id
[[WHERE {{work_date}}]]
GROUP BY e.full_name
ORDER BY "Attendance Rate" ASC;


-- ----------------------------------------------------------------------------
-- 2. Attendance Status Breakdown by Month  (Stacked Bar)
-- ----------------------------------------------------------------------------
SELECT
  DATE_TRUNC('month', work_date) AS "Month",
  COUNT(*) FILTER (WHERE status = 'Present') AS "Present",
  COUNT(*) FILTER (WHERE status = 'Remote') AS "Remote",
  COUNT(*) FILTER (WHERE status = 'Late') AS "Late",
  COUNT(*) FILTER (WHERE status = 'PTO') AS "PTO",
  COUNT(*) FILTER (WHERE status = 'Sick') AS "Sick",
  COUNT(*) FILTER (WHERE status = 'Absent') AS "Absent"
FROM ecommerce.employee_attendance
[[WHERE {{work_date}}]]
GROUP BY 1
ORDER BY 1;


-- ----------------------------------------------------------------------------
-- 3. Attendance Rate by Department  (Table, same conditional formatting
--    as card 1)
-- ----------------------------------------------------------------------------
SELECT
  e.department AS "Department",
  COUNT(*) AS "Scheduled Days",
  ROUND((100.0 * COUNT(*) FILTER (WHERE a.status IN ('Present', 'Remote'))
    / NULLIF(COUNT(*), 0))::numeric, 1) AS "Attendance Rate",
  COUNT(*) FILTER (WHERE a.status = 'Absent') AS "Absences",
  COUNT(*) FILTER (WHERE a.status = 'Late') AS "Late Days"
FROM ecommerce.employee_attendance a
JOIN ecommerce.employees e ON e.id = a.employee_id
[[WHERE {{work_date}}]]
GROUP BY e.department
ORDER BY "Attendance Rate" ASC;


-- ----------------------------------------------------------------------------
-- (Skipped on this build) Overall Attendance Rate, KPI Trend by month:
-- ----------------------------------------------------------------------------
-- SELECT
--   DATE_TRUNC('month', work_date) AS "Month",
--   ROUND((100.0 * COUNT(*) FILTER (WHERE status IN ('Present', 'Remote'))
--     / NULLIF(COUNT(*), 0))::numeric, 1) AS "Attendance Rate"
-- FROM ecommerce.employee_attendance
-- [[WHERE {{work_date}}]]
-- GROUP BY 1
-- ORDER BY 1;
