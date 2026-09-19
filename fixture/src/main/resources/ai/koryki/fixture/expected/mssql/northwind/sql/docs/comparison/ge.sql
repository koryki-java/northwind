-- >= : order lines at or above a quantity threshold.
SELECT
  od.order_id
, od.product_id
, od.quantity
FROM
 order_details od
WHERE
  od.quantity >= 10
ORDER BY
  od.order_id ASC
, od.product_id ASC
OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY