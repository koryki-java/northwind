SELECT
  o.order_id
, CAST(o.delivered_date AS TIME) AS order_time
FROM
 orders o
