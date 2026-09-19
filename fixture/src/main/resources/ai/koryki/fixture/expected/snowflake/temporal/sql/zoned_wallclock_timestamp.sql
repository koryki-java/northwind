-- wall-clock(zone) TIMESTAMP storage: a column declared in a named zone, converted declared-zone ->
-- model zone at the storage boundary (docs/TEMPORAL.md). KQL stays zone-free; the conversion is the
-- engine's job. Only unambiguous instants (nr 1,2) are asserted -- the DST fall-back overlap hour
-- (nr 3,4: 01:30 in America/New_York) resolves differently per engine, so it is not portable.
-- SQLite has no time-zone database, so wall-clock(zone) is impossible there and is permanently skipped.
SELECT
  CONVERT_TIMEZONE('America/New_York', 'UTC', c.ts_new_york) AS ts_new_york
, CONVERT_TIMEZONE('America/New_York', 'UTC', c.ts_new_york) + INTERVAL '1 hour' AS ts_new_york_plus1h
, CONVERT_TIMEZONE('America/New_York', 'UTC', c.ts_new_york) - INTERVAL '1 hour' AS ts_new_york_minus1h
FROM
 check_temporal c
WHERE
  c.nr <= 2