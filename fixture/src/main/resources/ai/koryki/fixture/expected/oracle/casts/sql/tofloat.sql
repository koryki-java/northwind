SELECT
  od.order_id
, CAST(od.discount AS FLOAT) AS discount_float
FROM
 order_details od