-- An array inside JSON that the catalog declares, .a.b[]: INTEGER, made into rows.
SELECT
  t.nr
, CAST(b.value AS INT)
, CAST(b.value AS INT) * 10 AS tenfold
FROM
 check_complex t
  CROSS APPLY OPENJSON(CASE WHEN LEFT(COALESCE(JSON_QUERY(t.doc, '$.a.b'), JSON_VALUE(t.doc, '$.a.b')), 1) = '[' THEN COALESCE(JSON_QUERY(t.doc, '$.a.b'), JSON_VALUE(t.doc, '$.a.b')) END) b