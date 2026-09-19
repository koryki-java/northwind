-- EPOCH-encoded timestamp column ± duration: the epoch integer is materialized to a TIMESTAMP
-- (epochToTimestamp) before the duration is applied, instead of `<bigint> + INTERVAL ...`.
-- duckdb-first.
SELECT
  CAST(from_unixtime(c.timestamp_unix_epoche) AS TIMESTAMP) + INTERVAL '1' DAY AS unix_plus_one_day
, CAST(from_unixtime((c.timestamp_java_epoche / 1000)) AS TIMESTAMP) - INTERVAL '2' HOUR AS java_minus_two_hours
FROM
 check_temporal c
WHERE
  c.nr = 1