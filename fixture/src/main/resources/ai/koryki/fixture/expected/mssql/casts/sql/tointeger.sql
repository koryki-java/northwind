SELECT
  od.order_id
, CAST(ROUND(od.unit_price, 0) AS INT) AS unit_price_int
FROM
 order_details od