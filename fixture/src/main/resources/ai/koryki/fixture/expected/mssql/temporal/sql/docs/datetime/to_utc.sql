-- to_utc: read a zoned wall-clock value and return it in UTC.
SELECT
  CAST(((CAST(c.ts_diff_base AS datetime2) AT TIME ZONE 'Eastern Standard Time') AT TIME ZONE 'UTC') AS datetime2) AS as_utc
FROM
 check_temporal c