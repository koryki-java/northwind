-- A condition on the rows of an outer unnest of JSON keeps every parent. SQL Server takes none there.
SELECT
  t.nr
, b.value
FROM
 check_complex t
  LEFT OUTER JOIN json_each((t.doc -> '$.a.b')) b ON json_type((t.doc -> '$.a.b')) = 'array' AND (b.value > 5)