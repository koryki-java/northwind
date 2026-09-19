-- least: the smaller of two values in the same row.
SELECT
  od.order_id
, od.product_id
, least(od.quantity, 10) AS capped_quantity
FROM
 order_details od
ORDER BY
  od.order_id ASC
, od.product_id ASC
FETCH FIRST 20 ROWS ONLY