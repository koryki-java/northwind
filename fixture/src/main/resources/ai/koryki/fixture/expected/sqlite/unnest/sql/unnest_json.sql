-- An array inside JSON that the catalog declares, .a.b[]: INTEGER, made into rows.
SELECT
  t.nr
, b.value
, b.value * 10 AS tenfold
FROM
 check_complex t
  INNER JOIN json_each((t.doc -> '$.a.b')) b ON json_type((t.doc -> '$.a.b')) = 'array'