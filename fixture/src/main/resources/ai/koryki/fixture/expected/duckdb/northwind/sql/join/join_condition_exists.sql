-- The condition-relationship as the correlation of an EXISTS: employees for whom a colleague of the
-- same city was hired later.
SELECT
  e.last_name
FROM
 employees e
WHERE
  
  EXISTS (
   SELECT
    1
  FROM
   employees l
  WHERE
   e.city = l.city
  AND
   e.hire_date < l.hire_date
  )
ORDER BY
  e.last_name ASC