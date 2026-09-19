-- to_utc: read a zoned wall-clock value and return it in UTC.
SELECT
  CONVERT_TZ(c.ts_diff_base, 'America/New_York', 'UTC') AS as_utc
FROM
 check_temporal c