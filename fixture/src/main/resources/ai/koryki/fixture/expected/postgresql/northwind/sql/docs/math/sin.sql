-- sin: trigonometric sine, argument in radians.
SELECT
  o.order_id
, round(CAST(sin(0) AS numeric), 6) AS sine_of_zero
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY