-- The counterpart to join_explicit_shared, written with the named criterion instead. Both describe
-- the same join, so their SQL must agree -- this is the check of the new form against the
-- established one rather than against itself.
SELECT
  et1.employee_id
, et1.territory_id
FROM
 employee_territories et1
  INNER JOIN employee_territories et2 ON
   et1.employee_id = et2.employee_id
  AND
   et1.territory_id = et2.territory_id