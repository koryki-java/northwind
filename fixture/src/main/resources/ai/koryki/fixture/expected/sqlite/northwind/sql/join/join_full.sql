-- FULL keeps the rows without a partner on both sides, where + keeps them on one. Employees joined
-- to their supervisor: the employee without one is in the result (as + would have it), and so is
-- every supervisor-side row that no employee matched.
SELECT
  COUNT(*) AS joined_rows
FROM
 employees e
  FULL OUTER JOIN employees m ON
   e.reports_to = m.employee_id