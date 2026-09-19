-- mod: order id modulo 7.
SELECT
  o.order_id
, mod(o.order_id, NULLIF(7, 0)) AS bucket
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY