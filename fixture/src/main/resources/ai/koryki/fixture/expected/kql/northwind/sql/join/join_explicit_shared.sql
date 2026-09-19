-- An explicitly written join instead of a named criterion. Both sides use the same column names,
-- so the shorthand form applies and stands for [employee_id=employee_id, territory_id=territory_id].
-- Only columns the model exposes as attributes can be named here, exactly as everywhere else in
-- KQL -- order_details, for instance, carries product_id in the schema but not in the model, so the
-- composite join over it is reachable only through its criterion.
SELECT
  et1.employee_id
, et1.territory_id
FROM
 employee_territories et1
  INNER JOIN employee_territories et2 ON
   et1.employee_id = et2.employee_id
  AND
   et1.territory_id = et2.territory_id