-- The join written after the source instead of before it. The grammar accepts both placements; the
-- formatter normalises to the leading one, as it always did for VIA.
SELECT
  et1.employee_id
, et1.territory_id
FROM
 employee_territories et1
  INNER JOIN employee_territories et2 ON
   et1.employee_id = et2.employee_id
  AND
   et1.territory_id = et2.territory_id