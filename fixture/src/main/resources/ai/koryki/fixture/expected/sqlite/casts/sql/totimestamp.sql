SELECT
  o.order_id
, datetime(o.order_date) AS ordered_at
FROM
 orders o