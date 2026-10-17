-- An array inside JSON that the catalog declares, .a.b[]: INTEGER, made into rows.
SELECT
  t.nr
, b.value
, b.value * 10 AS tenfold
FROM
 check_complex t
  CROSS JOIN UNNEST(CAST(json_extract(t.doc, '$.a.b') AS ARRAY(INTEGER))) AS b(value)