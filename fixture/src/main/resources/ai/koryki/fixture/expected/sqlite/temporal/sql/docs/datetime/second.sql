-- second: the second component of a TIMESTAMP.
SELECT
  CAST(strftime('%S', c.timestamp_timestamp) AS INTEGER) AS second_of_minute
FROM
 check_temporal c