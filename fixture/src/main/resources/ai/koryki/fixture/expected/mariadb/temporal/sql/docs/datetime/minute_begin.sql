-- minute_begin: the start of a TIMESTAMP's minute.
SELECT
  CAST(DATE_FORMAT(c.timestamp_timestamp, '%Y-%m-%d %H:%i:00') AS DATETIME) AS start_of_minute
FROM
 check_temporal c