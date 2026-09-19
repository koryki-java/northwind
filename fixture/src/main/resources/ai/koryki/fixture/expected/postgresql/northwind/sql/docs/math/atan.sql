-- atan: inverse tangent, result in radians.
SELECT
  o.order_id
, round(CAST(atan(0) AS numeric), 6) AS arctangent_of_zero
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY