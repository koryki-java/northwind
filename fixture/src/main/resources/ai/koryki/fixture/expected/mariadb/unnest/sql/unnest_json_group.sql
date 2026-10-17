-- The elements of the JSON array are rows: a count, a sum and an extreme over them.
SELECT
  count(b.`value`) AS elements
, sum(b.`value`) AS total
, max(b.`value`) AS biggest
FROM
 check_complex t
  INNER JOIN JSON_TABLE(CASE WHEN JSON_TYPE(JSON_QUERY(t.doc, '$')) = 'OBJECT' AND JSON_TYPE(JSON_QUERY(t.doc, '$.a')) = 'OBJECT' THEN COALESCE(JSON_QUERY(t.doc, '$.a.b'), JSON_VALUE(t.doc, '$.a.b')) END, '$[*]' COLUMNS (ordinal FOR ORDINALITY, `value` INT PATH '$')) b ON TRUE