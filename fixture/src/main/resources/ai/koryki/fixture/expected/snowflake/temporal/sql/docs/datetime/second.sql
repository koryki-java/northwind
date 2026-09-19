-- second: the second component of a TIMESTAMP.
SELECT
  second(c.timestamp_timestamp) AS second_of_minute
FROM
 check_temporal c