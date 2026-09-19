-- EPOCH-encoded timestamp column ± duration: the epoch integer is materialized to a TIMESTAMP
-- (epochToTimestamp) before the duration is applied, instead of `<bigint> + INTERVAL ...`.
-- duckdb-first.
SELECT
  TO_TIMESTAMP_NTZ(c.timestamp_unix_epoche, 0) + INTERVAL '1 day' AS unix_plus_one_day
, TO_TIMESTAMP_NTZ((c.timestamp_java_epoche / 1000), 0) - INTERVAL '2 hour' AS java_minus_two_hours
FROM
 check_temporal c
WHERE
  c.nr = 1