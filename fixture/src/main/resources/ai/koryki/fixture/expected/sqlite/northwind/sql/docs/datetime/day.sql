-- day: the day-of-month of the order date.
SELECT
  o.order_id
, CAST(strftime('%d', o.order_date) AS INTEGER) AS order_day
FROM
 orders o
ORDER BY
  o.order_id ASC
LIMIT 20