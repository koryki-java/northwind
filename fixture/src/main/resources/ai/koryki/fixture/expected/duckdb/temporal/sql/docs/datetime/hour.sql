-- hour: the hour component of a TIMESTAMP.
SELECT
  hour(c.timestamp_timestamp) AS hour_of_day
FROM
 check_temporal c