-- hour_begin: the start of a TIMESTAMP's hour -- the bucket an hourly trend groups by.
SELECT
  DATEADD(HOUR, DATEDIFF(HOUR, 0, c.timestamp_timestamp), 0) AS start_of_hour
FROM
 check_temporal c