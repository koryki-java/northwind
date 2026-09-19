-- EPOCH-encoded timestamp column ± duration: the epoch integer is materialized to a TIMESTAMP
-- (epochToTimestamp) before the duration is applied, instead of `<bigint> + INTERVAL ...`.
-- duckdb-first.
SELECT
  (TIMESTAMP '1970-01-01 00:00:00' + NUMTODSINTERVAL(c.timestamp_unix_epoche, 'SECOND')) + NUMTODSINTERVAL(1, 'DAY') AS unix_plus_one_day
, (TIMESTAMP '1970-01-01 00:00:00' + NUMTODSINTERVAL((c.timestamp_java_epoche / 1000), 'SECOND')) - NUMTODSINTERVAL(2, 'HOUR') AS java_minus_two_hours
FROM
 check_temporal c
WHERE
  c.nr = 1