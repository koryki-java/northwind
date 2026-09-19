SELECT
  o.order_id
, date(o.delivered_date) AS delivered_day
FROM
 orders o