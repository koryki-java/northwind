-- dayofweek: which weekday the order was placed on, Monday = 1.
SELECT
  o.order_id
, ((DATEDIFF(day, '19000101', o.order_date) % 7) + 1) AS order_weekday
FROM
 orders o
ORDER BY
  o.order_id ASC
OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY