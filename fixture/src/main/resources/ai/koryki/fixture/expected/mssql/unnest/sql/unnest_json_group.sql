-- The elements of the JSON array are rows: a count, a sum and an extreme over them.
SELECT
  count(CAST(b.value AS INT)) AS elements
, sum(CAST(b.value AS INT)) AS total
, max(CAST(b.value AS INT)) AS biggest
FROM
 check_complex t
  CROSS APPLY OPENJSON(CASE WHEN LEFT(COALESCE(JSON_QUERY(t.doc, '$.a.b'), JSON_VALUE(t.doc, '$.a.b')), 1) = '[' THEN COALESCE(JSON_QUERY(t.doc, '$.a.b'), JSON_VALUE(t.doc, '$.a.b')) END) b