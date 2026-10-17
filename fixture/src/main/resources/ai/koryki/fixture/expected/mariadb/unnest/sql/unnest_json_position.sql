-- The position of the element in the JSON array, from 1.
SELECT
  t.nr
, b.`ordinal`
, b.`value`
FROM
 check_complex t
  INNER JOIN JSON_TABLE(CASE WHEN JSON_TYPE(JSON_QUERY(t.doc, '$')) = 'OBJECT' AND JSON_TYPE(JSON_QUERY(t.doc, '$.a')) = 'OBJECT' THEN COALESCE(JSON_QUERY(t.doc, '$.a.b'), JSON_VALUE(t.doc, '$.a.b')) END, '$[*]' COLUMNS (ordinal FOR ORDINALITY, `value` INT PATH '$')) b ON TRUE