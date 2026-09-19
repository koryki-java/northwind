-- sin: trigonometric sine, argument in radians.
SELECT
  o.order_id
, round(sin(0), 6) AS sine_of_zero
FROM
 orders o
ORDER BY
  o.order_id ASC
OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY