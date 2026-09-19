SELECT
  od.order_id
, CAST(ROUND(od.quantity, 0) AS INTEGER) AS qty_smallint
FROM
 order_details od