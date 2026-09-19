-- minute_begin: the start of a TIMESTAMP's minute.
SELECT
  DATEADD(MINUTE, DATEDIFF(MINUTE, 0, c.timestamp_timestamp), 0) AS start_of_minute
FROM
 check_temporal c