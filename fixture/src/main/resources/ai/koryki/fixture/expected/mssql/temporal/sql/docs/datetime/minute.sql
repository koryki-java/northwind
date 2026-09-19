-- minute: the minute component of a TIMESTAMP.
SELECT
  DATEPART(MINUTE, c.timestamp_timestamp) AS minute_of_hour
FROM
 check_temporal c