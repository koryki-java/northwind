-- A row whose document has no array there has no rows; the outer form keeps it.
SELECT
  t.nr
, b.`value`
FROM
 check_complex t
  LEFT OUTER JOIN JSON_TABLE(CASE WHEN JSON_TYPE(JSON_QUERY(t.doc, '$')) = 'OBJECT' AND JSON_TYPE(JSON_QUERY(t.doc, '$.a')) = 'OBJECT' THEN COALESCE(JSON_QUERY(t.doc, '$.a.b'), JSON_VALUE(t.doc, '$.a.b')) END, '$[*]' COLUMNS (ordinal FOR ORDINALITY, `value` INT PATH '$')) b ON TRUE