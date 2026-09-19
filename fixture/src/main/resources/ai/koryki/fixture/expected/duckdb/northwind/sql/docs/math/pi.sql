-- pi: the mathematical constant pi.
SELECT
  o.order_id
, pi() AS pi_value
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY