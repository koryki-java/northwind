-- to_smallint: to a 16-bit integer.
SELECT
  CAST(ROUND(c.type_smallint, 0) AS SMALLINT) AS as_smallint
FROM
 check_type c