-- select_branches_json without what some dialects cannot read from JSON: the position from the end
-- (Trino and Snowflake have none in JSON, see select_branches_json) and the latitude (Oracle, see
-- there). What every dialect with a JSON column can answer, asked from the start.
SELECT
  t.nr
, (GET_PATH(t.branches_json, '[0].city'))::STRING AS first_city
, (GET_PATH(t.branches_json, '[1].zip'))::STRING AS second_zip
, (GET_PATH(t.branches_json, '[3].city'))::STRING AS fourth_city
FROM
 check_complex t