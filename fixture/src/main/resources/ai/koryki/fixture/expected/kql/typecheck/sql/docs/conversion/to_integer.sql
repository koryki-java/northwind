-- to_integer: truncate a decimal to a 32-bit integer.
SELECT
  CAST(c.type_decimal AS INTEGER) AS as_int
FROM
 check_type c