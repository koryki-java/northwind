-- An array inside JSON that the catalog declares, .a.b[]: INTEGER, made into rows.
SELECT
  t.nr
, b.`value`
, b.`value` * 10 AS tenfold
FROM
 check_complex t
  INNER JOIN JSON_TABLE(CASE WHEN JSON_TYPE(JSON_QUERY(t.doc, '$')) = 'OBJECT' AND JSON_TYPE(JSON_QUERY(t.doc, '$.a')) = 'OBJECT' THEN COALESCE(JSON_QUERY(t.doc, '$.a.b'), JSON_VALUE(t.doc, '$.a.b')) END, '$[*]' COLUMNS (ordinal FOR ORDINALITY, `value` INT PATH '$')) b ON TRUE