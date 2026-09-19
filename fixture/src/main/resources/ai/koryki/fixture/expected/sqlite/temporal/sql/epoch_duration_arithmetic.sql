-- EPOCH-encoded timestamp column ± duration: the epoch integer is materialized to a TIMESTAMP
-- (epochToTimestamp) before the duration is applied, instead of `<bigint> + INTERVAL ...`.
-- duckdb-first.
SELECT
  datetime(datetime(c.timestamp_unix_epoche, 'unixepoch'), '+1 days') AS unix_plus_one_day
, datetime(datetime((c.timestamp_java_epoche / 1000), 'unixepoch'), '-2 hours') AS java_minus_two_hours
FROM
 check_temporal c
WHERE
  c.nr = 1