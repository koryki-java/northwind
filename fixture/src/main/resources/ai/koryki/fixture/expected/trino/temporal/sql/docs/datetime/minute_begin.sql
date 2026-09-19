-- minute_begin: the start of a TIMESTAMP's minute.
SELECT
  date_trunc('minute', c.timestamp_timestamp) AS start_of_minute
FROM
 check_temporal c