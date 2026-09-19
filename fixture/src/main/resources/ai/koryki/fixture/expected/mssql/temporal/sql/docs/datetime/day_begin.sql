-- day_begin: midnight at the start of a TIMESTAMP's day.
SELECT
  CAST(CAST(c.timestamp_timestamp AS DATE) AS DATETIME2) AS start_of_day
FROM
 check_temporal c