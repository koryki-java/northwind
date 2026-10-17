-- An array inside JSON that the catalog declares, .a.b[]: INTEGER, made into rows.
SELECT
  t.nr
, b.COLUMN_VALUE
, b.COLUMN_VALUE * 10 AS tenfold
FROM
 check_complex t
  CROSS APPLY TABLE(CASE WHEN JSON_VALUE(CASE WHEN JSON_VALUE(t.doc, '$.type()') = 'object' AND JSON_VALUE(t.doc, '$.a.type()') = 'object' THEN JSON_QUERY(t.doc, '$.a.b' RETURNING JSON) END, '$.type()') = 'array' THEN CAST(MULTISET(SELECT jt.v FROM JSON_TABLE(CASE WHEN JSON_VALUE(t.doc, '$.type()') = 'object' AND JSON_VALUE(t.doc, '$.a.type()') = 'object' THEN JSON_QUERY(t.doc, '$.a.b' RETURNING JSON) END, '$[*]' COLUMNS (ord FOR ORDINALITY, v NUMBER PATH '$')) jt ORDER BY jt.ord) AS SYS.ODCINUMBERLIST) END) b