-- The elements of the JSON array are rows: a count, a sum and an extreme over them.
SELECT
  count(b.value) AS elements
, sum(b.value) AS total
, max(b.value) AS biggest
FROM
 check_complex t
  INNER JOIN json_each((t.doc -> '$.a.b')) b ON json_type((t.doc -> '$.a.b')) = 'array'