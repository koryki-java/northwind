-- to_time: keep the time part of a TIMESTAMP.
SELECT
  TO_CHAR(c.type_timestamp, 'HH24:MI:SS') AS as_time
FROM
 check_type c