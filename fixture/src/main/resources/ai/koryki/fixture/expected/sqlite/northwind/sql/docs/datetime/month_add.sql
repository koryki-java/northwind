-- month_add: one month after the order date.
SELECT
  o.order_id
, min(date(o.order_date, printf('%+d months', 1)), date(o.order_date, 'start of month', printf('%+d months', 1 + 1), '-1 day')) AS next_month
FROM
 orders o
ORDER BY
  o.order_id ASC
LIMIT 20