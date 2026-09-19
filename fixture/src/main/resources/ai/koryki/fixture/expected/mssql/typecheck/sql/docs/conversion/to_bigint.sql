-- to_bigint: to a 64-bit integer.
SELECT
  CAST(ROUND(c.type_integer, 0) AS BIGINT) AS as_bigint
FROM
 check_type c