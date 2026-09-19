-- dayofweek: which weekday the order was placed on, Monday = 1.
SELECT
  o.order_id
, (((CAST(strftime('%w', o.order_date) AS INTEGER) + 6) % 7) + 1) AS order_weekday
FROM
 orders o
ORDER BY
  o.order_id ASC
LIMIT 20