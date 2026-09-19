SELECT
  od.order_id
, CAST(od.discount AS REAL) AS discount_float
FROM
 order_details od