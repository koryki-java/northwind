SELECT
  od.order_id
, CAST(od.quantity AS SIGNED) AS qty_smallint
FROM
 order_details od