-- month_add: one month after the order date.
SELECT
  o.order_id
, (o.order_date + INTERVAL (1) MONTH) AS next_month
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY