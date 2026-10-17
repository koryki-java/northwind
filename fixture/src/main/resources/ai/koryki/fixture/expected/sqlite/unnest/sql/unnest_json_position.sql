-- The position of the element in the JSON array, from 1.
SELECT
  t.nr
, (b.key + 1)
, b.value
FROM
 check_complex t
  INNER JOIN json_each((t.doc -> '$.a.b')) b ON json_type((t.doc -> '$.a.b')) = 'array'