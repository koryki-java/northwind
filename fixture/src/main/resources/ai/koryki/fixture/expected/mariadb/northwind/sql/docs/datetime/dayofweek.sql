-- dayofweek: which weekday the order was placed on, Monday = 1.
SELECT
  o.order_id
, (WEEKDAY(o.order_date) + 1) AS order_weekday
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY