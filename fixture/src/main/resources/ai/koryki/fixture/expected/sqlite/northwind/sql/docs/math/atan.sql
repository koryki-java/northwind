-- atan: inverse tangent, result in radians.
SELECT
  o.order_id
, round(atan(0), 6) AS arctangent_of_zero
FROM
 orders o
ORDER BY
  o.order_id ASC
LIMIT 20