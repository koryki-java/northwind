-- multiply (*): gross amount of a line item.
SELECT
  od.order_id
, od.product_id
, round(od.unit_price * od.quantity, 2) AS gross
FROM
 order_details od
ORDER BY
  od.order_id ASC
, od.product_id ASC
OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY