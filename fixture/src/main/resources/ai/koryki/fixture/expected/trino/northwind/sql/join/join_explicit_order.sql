-- The column order is part of the meaning and has to survive into the ON clause. This is
-- join_explicit_shared with the two columns swapped: the same rows come back, but the comparisons
-- must appear in the written order. An implementation that sorts the columns or keeps them in a set
-- would pass the result check and fail here.
SELECT
  et1.employee_id
, et1.territory_id
FROM
 employee_territories et1
  INNER JOIN employee_territories et2 ON
   et1.territory_id = et2.territory_id
  AND
   et1.employee_id = et2.employee_id