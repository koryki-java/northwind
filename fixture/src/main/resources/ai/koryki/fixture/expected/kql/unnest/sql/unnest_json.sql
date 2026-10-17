-- An array inside JSON that the catalog declares, .a.b[]: INTEGER, made into rows.
SELECT
  t.nr
, b.item
, b.item * 10 AS tenfold
FROM
 check_complex t
  INNER JOIN UNNEST(CAST((t.doc -> '$.a.b') AS INTEGER[])) AS b(item) ON TRUE