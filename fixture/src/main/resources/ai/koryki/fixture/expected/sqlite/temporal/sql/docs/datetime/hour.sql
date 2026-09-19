-- hour: the hour component of a TIMESTAMP.
SELECT
  CAST(strftime('%H', c.timestamp_timestamp) AS INTEGER) AS hour_of_day
FROM
 check_temporal c