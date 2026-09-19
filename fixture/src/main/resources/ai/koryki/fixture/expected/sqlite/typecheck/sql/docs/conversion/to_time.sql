-- to_time: keep the time part of a TIMESTAMP.
SELECT
  time(c.type_timestamp) AS as_time
FROM
 check_type c