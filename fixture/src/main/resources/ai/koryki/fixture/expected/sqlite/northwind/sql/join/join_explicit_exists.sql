-- An explicit join inside EXISTS. The exists path reads the clause through the same helper as the
-- link path; without that they drift, and only a fixture using exists would notice.
SELECT
  et1.employee_id
FROM
 employee_territories et1
WHERE
  
  EXISTS (
   SELECT
    1
  FROM
   employee_territories et2
  WHERE
   et1.employee_id = et2.employee_id
  AND
   et1.territory_id = et2.territory_id
  )