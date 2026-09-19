-- quarter_begin: first day of the order's quarter.
SELECT
  o.order_id
, date(o.order_date, 'start of month', printf('%+d months', -((CAST(strftime('%m', o.order_date) AS INTEGER) - 1) % 3))) AS q_begin
FROM
 orders o
ORDER BY
  o.order_id ASC
LIMIT 20