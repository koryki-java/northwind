SELECT
  o.order_id
, date(o.shipped_date) AS shipped
FROM
 orders o