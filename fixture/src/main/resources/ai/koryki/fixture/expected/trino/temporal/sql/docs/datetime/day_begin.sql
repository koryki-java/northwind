-- day_begin: midnight at the start of a TIMESTAMP's day.
SELECT
  date_trunc('day', c.timestamp_timestamp) AS start_of_day
FROM
 check_temporal c