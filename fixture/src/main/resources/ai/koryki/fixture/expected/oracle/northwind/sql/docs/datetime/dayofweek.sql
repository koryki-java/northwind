-- dayofweek: which weekday the order was placed on, Monday = 1.
SELECT
  o.order_id
, (TRUNC(o.order_date) - TRUNC(o.order_date, 'IW') + 1) AS order_weekday
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY