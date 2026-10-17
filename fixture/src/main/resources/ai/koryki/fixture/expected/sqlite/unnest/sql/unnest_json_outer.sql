-- A row whose document has no array there has no rows; the outer form keeps it.
SELECT
  t.nr
, b.value
FROM
 check_complex t
  LEFT OUTER JOIN json_each((t.doc -> '$.a.b')) b ON json_type((t.doc -> '$.a.b')) = 'array'