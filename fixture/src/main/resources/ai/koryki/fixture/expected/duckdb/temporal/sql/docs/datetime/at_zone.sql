-- at_zone: read a model-zone wall-clock value in another zone.
SELECT
  ((c.ts_diff_base AT TIME ZONE 'UTC') AT TIME ZONE 'America/New_York') AS in_new_york
FROM
 check_temporal c