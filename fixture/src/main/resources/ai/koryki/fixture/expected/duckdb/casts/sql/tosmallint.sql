SELECT
  od.order_id
, CAST(od.quantity AS SMALLINT) AS qty_smallint
FROM
 order_details od