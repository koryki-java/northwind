-- to_decimal: fixed-point with precision and scale.
SELECT
  CAST(c.type_double AS DECIMAL(10, 2)) AS as_money
FROM
 check_type c