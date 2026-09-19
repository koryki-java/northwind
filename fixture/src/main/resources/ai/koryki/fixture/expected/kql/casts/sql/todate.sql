SELECT
  o.order_id
, CAST(o.shipped_date AS DATE) AS shipped
FROM
 orders o
