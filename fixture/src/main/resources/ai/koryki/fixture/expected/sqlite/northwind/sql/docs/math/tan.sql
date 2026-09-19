-- tan: trigonometric tangent, argument in radians.
SELECT
  o.order_id
, round(tan(0), 6) AS tangent_of_zero
FROM
 orders o
ORDER BY
  o.order_id ASC
LIMIT 20