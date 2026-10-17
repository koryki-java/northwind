-- A row whose document has no array there has no rows; the outer form keeps it.
SELECT
  t.nr
, CAST(b.value AS INT)
FROM
 check_complex t
  OUTER APPLY OPENJSON(CASE WHEN LEFT(COALESCE(JSON_QUERY(t.doc, '$.a.b'), JSON_VALUE(t.doc, '$.a.b')), 1) = '[' THEN COALESCE(JSON_QUERY(t.doc, '$.a.b'), JSON_VALUE(t.doc, '$.a.b')) END) b