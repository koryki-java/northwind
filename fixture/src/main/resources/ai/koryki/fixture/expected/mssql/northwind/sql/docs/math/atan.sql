-- atan: inverse tangent, result in radians.
SELECT
  o.order_id
, round(atan(0), 6) AS arctangent_of_zero
FROM
 orders o
ORDER BY
  o.order_id ASC
OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY