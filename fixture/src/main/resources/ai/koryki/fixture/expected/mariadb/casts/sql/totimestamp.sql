SELECT
  o.order_id
, CAST(o.order_date AS DATETIME) AS ordered_at
FROM
 orders o