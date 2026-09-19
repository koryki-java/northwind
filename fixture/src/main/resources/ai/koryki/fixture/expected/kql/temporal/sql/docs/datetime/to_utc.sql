-- to_utc: read a zoned wall-clock value and return it in UTC.
SELECT
  ((c.ts_diff_base AT TIME ZONE 'America/New_York') AT TIME ZONE 'UTC') AS as_utc
FROM
 check_temporal c