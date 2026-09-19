-- month_add: one month after the order date.
SELECT
  o.order_id
, date_add('month', 1, o.order_date) AS next_month
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY