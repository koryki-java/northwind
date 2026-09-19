-- to_date: drop the time part of a TIMESTAMP.
SELECT
  CAST(c.type_timestamp AS DATE) AS as_date
FROM
 check_type c