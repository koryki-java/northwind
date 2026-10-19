-- select_branches_json without the position from the end, which Trino, Snowflake and SQL Server do not
-- have in JSON (see select_branches_json). What every dialect with a JSON column can answer, asked
-- from the start.
SELECT
  t.nr
, CASE WHEN JSON_TYPE(JSON_QUERY(t.branches_json, '$')) = 'ARRAY' AND JSON_TYPE(JSON_QUERY(t.branches_json, '$[0]')) = 'OBJECT' THEN COALESCE(JSON_QUERY(t.branches_json, '$[0].city'), JSON_VALUE(t.branches_json, '$[0].city')) END AS first_city
, CAST(CASE WHEN JSON_TYPE(JSON_QUERY(t.branches_json, '$')) = 'ARRAY' AND JSON_TYPE(JSON_QUERY(t.branches_json, '$[0]')) = 'OBJECT' AND JSON_TYPE(JSON_QUERY(t.branches_json, '$[0].geo')) = 'OBJECT' THEN COALESCE(JSON_QUERY(t.branches_json, '$[0].geo.lat'), JSON_VALUE(t.branches_json, '$[0].geo.lat')) END AS DOUBLE) AS first_lat
, CASE WHEN JSON_TYPE(JSON_QUERY(t.branches_json, '$')) = 'ARRAY' AND JSON_TYPE(JSON_QUERY(t.branches_json, '$[1]')) = 'OBJECT' THEN COALESCE(JSON_QUERY(t.branches_json, '$[1].zip'), JSON_VALUE(t.branches_json, '$[1].zip')) END AS second_zip
, CASE WHEN JSON_TYPE(JSON_QUERY(t.branches_json, '$')) = 'ARRAY' AND JSON_TYPE(JSON_QUERY(t.branches_json, '$[3]')) = 'OBJECT' THEN COALESCE(JSON_QUERY(t.branches_json, '$[3].city'), JSON_VALUE(t.branches_json, '$[3].city')) END AS fourth_city
FROM
 check_complex t