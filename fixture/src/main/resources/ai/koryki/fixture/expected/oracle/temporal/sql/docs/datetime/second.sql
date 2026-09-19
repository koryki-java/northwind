-- second: the second component of a TIMESTAMP.
SELECT
  TRUNC(EXTRACT(SECOND FROM c.timestamp_timestamp)) AS second_of_minute
FROM
 check_temporal c