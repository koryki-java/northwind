-- cos: trigonometric cosine, argument in radians.
SELECT
  o.order_id
, round(cos(0), 6) AS cosine_of_zero
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY