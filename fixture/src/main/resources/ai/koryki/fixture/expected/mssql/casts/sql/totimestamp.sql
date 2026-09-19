SELECT
  o.order_id
, CAST(o.order_date AS DATETIME2) AS ordered_at
FROM
 orders o