-- to_utc: read a zoned wall-clock value and return it in UTC.
SELECT
  CAST(with_timezone(c.ts_diff_base, 'America/New_York') AT TIME ZONE 'UTC' AS TIMESTAMP) AS as_utc
FROM
 check_temporal c