SELECT
  o.order_id
, CAST(o.delivered_date AS DATE) AS delivered_day
FROM
 orders o
