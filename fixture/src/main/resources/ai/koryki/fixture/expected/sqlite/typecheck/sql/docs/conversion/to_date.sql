-- to_date: drop the time part of a TIMESTAMP.
SELECT
  date(c.type_timestamp) AS as_date
FROM
 check_type c