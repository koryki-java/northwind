-- select_branches_json without the position from the end, which Trino, Snowflake and SQL Server do not
-- have in JSON (see select_branches_json). What every dialect with a JSON column can answer, asked
-- from the start.
SELECT
  t.nr
, (GET_PATH(t.branches_json, '[0].city'))::STRING AS first_city
, CAST((GET_PATH(t.branches_json, '[0].geo.lat'))::STRING AS DOUBLE) AS first_lat
, (GET_PATH(t.branches_json, '[1].zip'))::STRING AS second_zip
, (GET_PATH(t.branches_json, '[3].city'))::STRING AS fourth_city
FROM
 check_complex t