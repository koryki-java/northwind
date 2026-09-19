-- day_begin: midnight at the start of a TIMESTAMP's day.
SELECT
  CAST(DATE(c.timestamp_timestamp) AS DATETIME) AS start_of_day
FROM
 check_temporal c