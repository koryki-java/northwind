-- select_branches_json without the position from the end, which Trino, Snowflake and SQL Server do not
-- have in JSON (see select_branches_json). What every dialect with a JSON column can answer, asked
-- from the start.
SELECT
  t.nr
, (t.branches_json -> 0 ->> 'city') AS first_city
, CAST((t.branches_json -> 0 -> 'geo' ->> 'lat') AS DOUBLE PRECISION) AS first_lat
, (t.branches_json -> 1 ->> 'zip') AS second_zip
, (t.branches_json -> 3 ->> 'city') AS fourth_city
FROM
 check_complex t