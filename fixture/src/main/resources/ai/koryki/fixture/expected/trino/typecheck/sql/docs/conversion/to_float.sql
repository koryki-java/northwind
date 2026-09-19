-- to_float: to single-precision floating point.
SELECT
  CAST(c.type_decimal AS REAL) AS as_float
FROM
 check_type c