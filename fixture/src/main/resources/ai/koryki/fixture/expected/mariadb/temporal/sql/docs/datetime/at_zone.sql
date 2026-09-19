-- at_zone: read a model-zone wall-clock value in another zone.
SELECT
  CONVERT_TZ(c.ts_diff_base, 'UTC', 'America/New_York') AS in_new_york
FROM
 check_temporal c