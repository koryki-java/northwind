-- hour_begin: the start of a TIMESTAMP's hour -- the bucket an hourly trend groups by.
SELECT
  date_trunc('hour', c.timestamp_timestamp) AS start_of_hour
FROM
 check_temporal c