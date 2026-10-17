-- A filter on the rows of the JSON array keeps the matching elements.
SELECT
  t.nr
, b.item
FROM
 check_complex t
  INNER JOIN UNNEST(CAST((t.doc -> '$.a.b') AS INTEGER[])) AS b(item) ON TRUE
WHERE
  b.item > 5