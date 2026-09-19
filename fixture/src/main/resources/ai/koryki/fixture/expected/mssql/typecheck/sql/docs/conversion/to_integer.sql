-- to_integer: truncate a decimal to a 32-bit integer.
SELECT
  CAST(ROUND(c.type_decimal, 0) AS INT) AS as_int
FROM
 check_type c