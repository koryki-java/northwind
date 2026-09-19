-- day_add: seven days after the order date.
SELECT
  o.order_id
, date(o.order_date, printf('%+d days', 7)) AS plus_week
FROM
 orders o
ORDER BY
  o.order_id ASC
LIMIT 20