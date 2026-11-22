-- Two FULL joins in a row: employees, their supervisors, and the supervisors' supervisors. The
-- second join is on the first one's supervisor, which is missing in the rows the first join padded;
-- those rows find no partner, and the employees nobody supervises are kept by the second join too.
SELECT
  COUNT(*) AS joined_rows
FROM
 employees e
  FULL OUTER JOIN employees m ON
   e.reports_to = m.employee_id
    FULL OUTER JOIN employees n ON
     m.reports_to = n.employee_id