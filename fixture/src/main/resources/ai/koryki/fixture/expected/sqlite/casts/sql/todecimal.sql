SELECT
  od.order_id
, ROUND(od.discount, 2) AS discount_decimal
FROM
 order_details od