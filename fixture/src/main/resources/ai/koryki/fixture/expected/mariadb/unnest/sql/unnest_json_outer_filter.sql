-- A condition on the rows of an outer unnest of JSON keeps every parent. SQL Server takes none there.
SELECT
  t.nr
, b.`value`
FROM
 check_complex t
  LEFT OUTER JOIN JSON_TABLE(CASE WHEN JSON_TYPE(JSON_QUERY(t.doc, '$')) = 'OBJECT' AND JSON_TYPE(JSON_QUERY(t.doc, '$.a')) = 'OBJECT' THEN COALESCE(JSON_QUERY(t.doc, '$.a.b'), JSON_VALUE(t.doc, '$.a.b')) END, '$[*]' COLUMNS (ordinal FOR ORDINALITY, `value` INT PATH '$')) b ON b.`value` > 5