-- day_add: seven days after the order date.
SELECT
  o.order_id
, (o.order_date + INTERVAL (7) DAY) AS plus_week
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY