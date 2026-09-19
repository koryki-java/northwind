-- at_zone: read a model-zone wall-clock value in another zone.
SELECT
  CONVERT_TIMEZONE('UTC', 'America/New_York', c.ts_diff_base) AS in_new_york
FROM
 check_temporal c