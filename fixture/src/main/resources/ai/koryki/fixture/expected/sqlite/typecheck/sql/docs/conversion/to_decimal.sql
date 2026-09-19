-- to_decimal: fixed-point with precision and scale.
SELECT
  ROUND(c.type_double, 2) AS as_money
FROM
 check_type c