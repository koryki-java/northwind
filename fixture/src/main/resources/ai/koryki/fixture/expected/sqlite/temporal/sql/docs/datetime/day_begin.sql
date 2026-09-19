-- day_begin: midnight at the start of a TIMESTAMP's day.
SELECT
  datetime(c.timestamp_timestamp, 'start of day') AS start_of_day
FROM
 check_temporal c