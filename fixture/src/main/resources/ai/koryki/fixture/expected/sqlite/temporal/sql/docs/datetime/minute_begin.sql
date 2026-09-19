-- minute_begin: the start of a TIMESTAMP's minute.
SELECT
  datetime(strftime('%Y-%m-%d %H:%M:00', c.timestamp_timestamp)) AS start_of_minute
FROM
 check_temporal c