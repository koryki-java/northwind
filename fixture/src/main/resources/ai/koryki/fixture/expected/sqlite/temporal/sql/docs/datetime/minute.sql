-- minute: the minute component of a TIMESTAMP.
SELECT
  CAST(strftime('%M', c.timestamp_timestamp) AS INTEGER) AS minute_of_hour
FROM
 check_temporal c