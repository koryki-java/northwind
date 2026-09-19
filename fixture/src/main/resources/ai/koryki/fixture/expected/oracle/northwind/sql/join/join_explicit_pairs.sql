-- The pair form of join_explicit_shared. [a, b] is only shorthand for [a=a, b=b], so the SQL below
-- must be identical to that fixture's, comment lines aside -- if the two ever diverge, the two
-- grammar branches have grown apart.
SELECT
  et1.employee_id
, et1.territory_id
FROM
 employee_territories et1
  INNER JOIN employee_territories et2 ON
   et1.employee_id = et2.employee_id
  AND
   et1.territory_id = et2.territory_id