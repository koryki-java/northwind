-- <= : order lines at or below a discount ceiling.
SELECT
  od.order_id
, od.product_id
, od.discount
FROM
 order_details od
WHERE
  od.discount <= 0.1
ORDER BY
  od.order_id ASC
, od.product_id ASC
OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY