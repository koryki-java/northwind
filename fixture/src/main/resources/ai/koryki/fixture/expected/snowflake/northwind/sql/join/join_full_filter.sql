-- A filter on the alias of a FULL join belongs in the ON clause, as for +. It restricts which rows
-- match, so the rows that do not match stay on both sides: this is not the inner join of the
-- supervisors with that title.
SELECT
  COUNT(*) AS joined_rows
FROM
 employees e
  FULL OUTER JOIN employees m ON
   e.reports_to = m.employee_id
  AND
   m.title = 'Sales Manager'