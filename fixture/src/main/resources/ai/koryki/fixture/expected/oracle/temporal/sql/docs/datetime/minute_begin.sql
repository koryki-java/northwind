-- minute_begin: the start of a TIMESTAMP's minute.
SELECT
  TRUNC(CAST(c.timestamp_timestamp AS DATE), 'MI') AS start_of_minute
FROM
 check_temporal c