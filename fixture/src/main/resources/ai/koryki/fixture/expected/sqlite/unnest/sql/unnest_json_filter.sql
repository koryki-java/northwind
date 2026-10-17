-- A filter on the rows of the JSON array keeps the matching elements.
SELECT
  t.nr
, b.value
FROM
 check_complex t
  INNER JOIN json_each((t.doc -> '$.a.b')) b ON json_type((t.doc -> '$.a.b')) = 'array'
WHERE
  b.value > 5