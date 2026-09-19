SELECT
  o.order_id
, time(o.delivered_date) AS order_time
FROM
 orders o