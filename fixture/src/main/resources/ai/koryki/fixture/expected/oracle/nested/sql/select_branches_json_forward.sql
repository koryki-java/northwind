-- select_branches_json without the position from the end, which Trino, Snowflake and SQL Server do not
-- have in JSON (see select_branches_json). What every dialect with a JSON column can answer, asked
-- from the start.
SELECT
  t.nr
, CASE WHEN JSON_VALUE(t.branches_json, '$.type()') = 'array' AND JSON_VALUE(t.branches_json, '$[0].type()') = 'object' THEN JSON_VALUE(t.branches_json, '$[0].city') END AS first_city
, CAST(CASE WHEN JSON_VALUE(t.branches_json, '$.type()') = 'array' AND JSON_VALUE(t.branches_json, '$[0].type()') = 'object' AND JSON_VALUE(t.branches_json, '$[0].geo.type()') = 'object' THEN JSON_VALUE(t.branches_json, '$[0].geo.lat' RETURNING NUMBER) END AS BINARY_DOUBLE) AS first_lat
, CASE WHEN JSON_VALUE(t.branches_json, '$.type()') = 'array' AND JSON_VALUE(t.branches_json, '$[1].type()') = 'object' THEN JSON_VALUE(t.branches_json, '$[1].zip') END AS second_zip
, CASE WHEN JSON_VALUE(t.branches_json, '$.type()') = 'array' AND JSON_VALUE(t.branches_json, '$[3].type()') = 'object' THEN JSON_VALUE(t.branches_json, '$[3].city') END AS fourth_city
FROM
 check_complex t