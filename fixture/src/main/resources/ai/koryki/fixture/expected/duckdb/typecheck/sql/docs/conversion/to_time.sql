-- to_time: keep the time part of a TIMESTAMP.
SELECT
  CAST(c.type_timestamp AS TIME) AS as_time
FROM
 check_type c