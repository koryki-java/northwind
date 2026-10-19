-- select_branches_json without the position from the end, which Trino, Snowflake and SQL Server do not
-- have in JSON (see select_branches_json). What every dialect with a JSON column can answer, asked
-- from the start.
SELECT
  t.nr
, COALESCE(JSON_QUERY(t.branches_json, '$[0].city'), JSON_VALUE(t.branches_json, '$[0].city')) AS first_city
, CAST(COALESCE(JSON_QUERY(t.branches_json, '$[0].geo.lat'), JSON_VALUE(t.branches_json, '$[0].geo.lat')) AS FLOAT) AS first_lat
, COALESCE(JSON_QUERY(t.branches_json, '$[1].zip'), JSON_VALUE(t.branches_json, '$[1].zip')) AS second_zip
, COALESCE(JSON_QUERY(t.branches_json, '$[3].city'), JSON_VALUE(t.branches_json, '$[3].city')) AS fourth_city
FROM
 check_complex t