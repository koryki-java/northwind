SELECT
  o.order_id
, CAST(o.order_date AS TIMESTAMP) AS ordered_at
FROM
 orders o
