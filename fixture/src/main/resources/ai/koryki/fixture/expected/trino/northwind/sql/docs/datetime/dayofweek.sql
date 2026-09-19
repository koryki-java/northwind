-- dayofweek: which weekday the order was placed on, Monday = 1.
SELECT
  o.order_id
, day_of_week(o.order_date) AS order_weekday
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY