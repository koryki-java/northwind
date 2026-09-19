-- < : order lines priced below a threshold.
SELECT
  od.order_id
, od.product_id
, od.unit_price
FROM
 order_details od
WHERE
  od.unit_price < 10
ORDER BY
  od.order_id ASC
, od.product_id ASC
OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY