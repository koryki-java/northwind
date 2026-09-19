-- hour_begin: the start of a TIMESTAMP's hour -- the bucket an hourly trend groups by.
SELECT
  CAST(DATE_FORMAT(c.timestamp_timestamp, '%Y-%m-%d %H:00:00') AS DATETIME) AS start_of_hour
FROM
 check_temporal c