-- to_utc: read a zoned wall-clock value and return it in UTC.
SELECT
  CAST(FROM_TZ(CAST(c.ts_diff_base AS TIMESTAMP), 'America/New_York') AT TIME ZONE 'UTC' AS TIMESTAMP) AS as_utc
FROM
 check_temporal c