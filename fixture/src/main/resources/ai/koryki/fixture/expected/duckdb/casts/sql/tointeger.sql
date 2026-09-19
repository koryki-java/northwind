SELECT
  od.order_id
, CAST(od.unit_price AS INTEGER) AS unit_price_int
FROM
 order_details od