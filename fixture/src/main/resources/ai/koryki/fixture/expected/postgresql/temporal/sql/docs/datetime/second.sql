-- second: the second component of a TIMESTAMP.
SELECT
  CAST(trunc(EXTRACT(SECOND FROM c.timestamp_timestamp)) AS INTEGER) AS second_of_minute
FROM
 check_temporal c