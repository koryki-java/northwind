-- greatest: the larger of two values in the same row.
SELECT
  od.order_id
, od.product_id
, round(greatest(od.unit_price, 20), 2) AS at_least_twenty
FROM
 order_details od
ORDER BY
  od.order_id ASC
, od.product_id ASC
OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY