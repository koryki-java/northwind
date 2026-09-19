-- at_zone: read a model-zone wall-clock value in another zone.
SELECT
  CAST(FROM_TZ(CAST(c.ts_diff_base AS TIMESTAMP), 'UTC') AT TIME ZONE 'America/New_York' AS TIMESTAMP) AS in_new_york
FROM
 check_temporal c