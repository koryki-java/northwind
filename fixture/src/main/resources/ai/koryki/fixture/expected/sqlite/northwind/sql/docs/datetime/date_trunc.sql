-- date_trunc: truncate the order date to the month.
SELECT
  o.order_id
, date(o.order_date, 'start of month') AS month_start
FROM
 orders o
ORDER BY
  o.order_id ASC
LIMIT 20