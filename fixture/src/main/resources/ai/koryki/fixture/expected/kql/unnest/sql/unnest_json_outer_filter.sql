-- A condition on the rows of an outer unnest of JSON keeps every parent. SQL Server takes none there.
SELECT
  t.nr
, b.item
FROM
 check_complex t
  LEFT OUTER JOIN UNNEST(CAST((t.doc -> '$.a.b') AS INTEGER[])) AS b(item) ON b.item > 5