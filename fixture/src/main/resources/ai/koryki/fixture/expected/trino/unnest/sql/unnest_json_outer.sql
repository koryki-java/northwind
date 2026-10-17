-- A row whose document has no array there has no rows; the outer form keeps it.
SELECT
  t.nr
, b.value
FROM
 check_complex t
  LEFT OUTER JOIN UNNEST(CAST(json_extract(t.doc, '$.a.b') AS ARRAY(INTEGER))) AS b(value) ON TRUE