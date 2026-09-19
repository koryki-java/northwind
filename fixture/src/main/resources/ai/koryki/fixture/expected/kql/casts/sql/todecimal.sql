SELECT
  od.order_id
, CAST(od.discount AS DECIMAL(5, 2)) AS discount_decimal
FROM
 order_details od
