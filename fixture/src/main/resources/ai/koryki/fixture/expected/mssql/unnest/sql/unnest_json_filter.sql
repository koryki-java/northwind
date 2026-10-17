-- A filter on the rows of the JSON array keeps the matching elements.
SELECT
  t.nr
, CAST(b.value AS INT)
FROM
 check_complex t
  CROSS APPLY OPENJSON(CASE WHEN LEFT(COALESCE(JSON_QUERY(t.doc, '$.a.b'), JSON_VALUE(t.doc, '$.a.b')), 1) = '[' THEN COALESCE(JSON_QUERY(t.doc, '$.a.b'), JSON_VALUE(t.doc, '$.a.b')) END) b
WHERE
  CAST(b.value AS INT) > 5