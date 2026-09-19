-- An explicit join marked optional: LEFT OUTER JOIN, with the columns still in the ON clause.
SELECT
  et1.employee_id
, et2.territory_id
FROM
 employee_territories et1
  LEFT OUTER JOIN employee_territories et2 ON
   et1.employee_id = et2.employee_id
  AND
   et1.territory_id = et2.territory_id