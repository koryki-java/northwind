-- multiply (*): gross amount of a line item.
SELECT
  od.order_id
, od.product_id
, round(CAST(od.unit_price * od.quantity AS numeric), 2) AS gross
FROM
 order_details od
ORDER BY
  od.order_id ASC
, od.product_id ASC
FETCH FIRST 20 ROWS ONLY