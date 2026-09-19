-- to_utc: read a zoned wall-clock value and return it in UTC.
SELECT
  CONVERT_TIMEZONE('America/New_York', 'UTC', c.ts_diff_base) AS as_utc
FROM
 check_temporal c