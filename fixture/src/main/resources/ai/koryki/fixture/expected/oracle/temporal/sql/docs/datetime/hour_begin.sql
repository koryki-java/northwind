-- hour_begin: the start of a TIMESTAMP's hour -- the bucket an hourly trend groups by.
SELECT
  TRUNC(CAST(c.timestamp_timestamp AS DATE), 'HH') AS start_of_hour
FROM
 check_temporal c