-- to_double: to double-precision floating point.
SELECT
  CAST(c.type_decimal AS BINARY_DOUBLE) AS as_double
FROM
 check_type c