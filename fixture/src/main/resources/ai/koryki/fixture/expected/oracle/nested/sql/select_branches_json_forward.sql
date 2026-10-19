-- select_branches_json without what some dialects cannot read from JSON: the position from the end
-- (Trino and Snowflake have none in JSON, see select_branches_json) and the latitude (Oracle, see
-- there). What every dialect with a JSON column can answer, asked from the start.
SELECT
  t.nr
, CASE WHEN JSON_VALUE(t.branches_json, '$.type()') = 'array' AND JSON_VALUE(t.branches_json, '$[0].type()') = 'object' THEN JSON_VALUE(t.branches_json, '$[0].city') END AS first_city
, CASE WHEN JSON_VALUE(t.branches_json, '$.type()') = 'array' AND JSON_VALUE(t.branches_json, '$[1].type()') = 'object' THEN JSON_VALUE(t.branches_json, '$[1].zip') END AS second_zip
, CASE WHEN JSON_VALUE(t.branches_json, '$.type()') = 'array' AND JSON_VALUE(t.branches_json, '$[3].type()') = 'object' THEN JSON_VALUE(t.branches_json, '$[3].city') END AS fourth_city
FROM
 check_complex t