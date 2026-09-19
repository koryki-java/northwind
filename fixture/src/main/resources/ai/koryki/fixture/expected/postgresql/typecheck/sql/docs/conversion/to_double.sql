-- to_double: to double-precision floating point.
SELECT
  CAST(c.type_decimal AS DOUBLE PRECISION) AS as_double
FROM
 check_type c