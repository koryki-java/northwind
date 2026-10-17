-- The elements of the JSON array are rows: a count, a sum and an extreme over them.
SELECT
  count(b.COLUMN_VALUE) AS elements
, sum(b.COLUMN_VALUE) AS total
, max(b.COLUMN_VALUE) AS biggest
FROM
 check_complex t
  CROSS APPLY TABLE(CASE WHEN JSON_VALUE(CASE WHEN JSON_VALUE(t.doc, '$.type()') = 'object' AND JSON_VALUE(t.doc, '$.a.type()') = 'object' THEN JSON_QUERY(t.doc, '$.a.b' RETURNING JSON) END, '$.type()') = 'array' THEN CAST(MULTISET(SELECT jt.v FROM JSON_TABLE(CASE WHEN JSON_VALUE(t.doc, '$.type()') = 'object' AND JSON_VALUE(t.doc, '$.a.type()') = 'object' THEN JSON_QUERY(t.doc, '$.a.b' RETURNING JSON) END, '$[*]' COLUMNS (ord FOR ORDINALITY, v NUMBER PATH '$')) jt ORDER BY jt.ord) AS SYS.ODCINUMBERLIST) END) b