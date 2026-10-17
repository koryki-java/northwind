-- The position of the element in the JSON array, from 1.
SELECT
  t.nr
, (CAST(b.[key] AS INT) + 1)
, CAST(b.value AS INT)
FROM
 check_complex t
  CROSS APPLY OPENJSON(CASE WHEN LEFT(COALESCE(JSON_QUERY(t.doc, '$.a.b'), JSON_VALUE(t.doc, '$.a.b')), 1) = '[' THEN COALESCE(JSON_QUERY(t.doc, '$.a.b'), JSON_VALUE(t.doc, '$.a.b')) END) b