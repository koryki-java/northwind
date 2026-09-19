-- month: the month component of the order date.
SELECT
  o.order_id
, CAST(strftime('%m', o.order_date) AS INTEGER) AS order_month
FROM
 orders o
ORDER BY
  o.order_id ASC
LIMIT 20