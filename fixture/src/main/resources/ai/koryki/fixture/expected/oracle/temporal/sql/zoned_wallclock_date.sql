-- wall-clock(zone) DATE storage: a column declared in a named zone, converted declared-zone -> model
-- zone at the storage boundary (docs/TEMPORAL.md). A wall-clock date is anchored at start-of-day in its
-- zone, so it can land on the adjacent model-zone day. KQL stays zone-free; the conversion is the
-- engine's job. Only unambiguous instants (nr 1,2) are asserted (see zoned_wallclock_timestamp).
-- SQLite has no time-zone database, so wall-clock(zone) is impossible there and is permanently skipped.
SELECT
  TRUNC(CAST(FROM_TZ(CAST(c.date_new_york AS TIMESTAMP), 'America/New_York') AT TIME ZONE 'UTC' AS DATE)) AS date_new_york
, (ADD_MONTHS(TRUNC(CAST(FROM_TZ(CAST(c.date_new_york AS TIMESTAMP), 'America/New_York') AT TIME ZONE 'UTC' AS DATE)), 3) - GREATEST(EXTRACT(DAY FROM ADD_MONTHS(TRUNC(CAST(FROM_TZ(CAST(c.date_new_york AS TIMESTAMP), 'America/New_York') AT TIME ZONE 'UTC' AS DATE)), 3)) - EXTRACT(DAY FROM TRUNC(CAST(FROM_TZ(CAST(c.date_new_york AS TIMESTAMP), 'America/New_York') AT TIME ZONE 'UTC' AS DATE))), 0)) AS date_new_york_plus1q
, TRUNC(CAST(FROM_TZ(CAST(c.date_new_york AS TIMESTAMP), 'America/New_York') AT TIME ZONE 'UTC' AS DATE)) + NUMTODSINTERVAL(1, 'HOUR') AS date_new_york_plus1h
FROM
 check_temporal c
WHERE
  c.nr <= 2