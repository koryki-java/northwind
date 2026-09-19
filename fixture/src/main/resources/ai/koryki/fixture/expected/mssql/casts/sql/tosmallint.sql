SELECT
  od.order_id
, CAST(ROUND(od.quantity, 0) AS SMALLINT) AS qty_smallint
FROM
 order_details od