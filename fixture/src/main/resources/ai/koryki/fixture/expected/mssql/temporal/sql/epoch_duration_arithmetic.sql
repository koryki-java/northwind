-- EPOCH-encoded timestamp column ± duration: the epoch integer is materialized to a TIMESTAMP
-- (epochToTimestamp) before the duration is applied, instead of `<bigint> + INTERVAL ...`.
-- duckdb-first.
SELECT
  DATEADD(DAY, 1, DATEADD(SECOND, c.timestamp_unix_epoche, '1970-01-01')) AS unix_plus_one_day
, DATEADD(HOUR, -2, DATEADD(SECOND, (c.timestamp_java_epoche / 1000), '1970-01-01')) AS java_minus_two_hours
FROM
 check_temporal c
WHERE
  c.nr = 1