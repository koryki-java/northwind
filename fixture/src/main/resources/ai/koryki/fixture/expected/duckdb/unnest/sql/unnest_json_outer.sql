-- A row whose document has no array there has no rows; the outer form keeps it.
SELECT
  t.nr
, b.item
FROM
 check_complex t
  LEFT OUTER JOIN UNNEST(CAST((t.doc -> '$.a.b') AS INTEGER[])) AS b(item) ON TRUE