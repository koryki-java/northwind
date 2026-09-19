-- minute: the minute component of a TIMESTAMP.
SELECT
  EXTRACT(MINUTE FROM c.timestamp_timestamp) AS minute_of_hour
FROM
 check_temporal c