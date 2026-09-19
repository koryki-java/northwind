-- at_zone: read a model-zone wall-clock value in another zone.
SELECT
  CAST(((CAST(c.ts_diff_base AS datetime2) AT TIME ZONE 'UTC') AT TIME ZONE 'Eastern Standard Time') AS datetime2) AS in_new_york
FROM
 check_temporal c