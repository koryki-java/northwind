-- quarter_end: last day of the order's quarter.
SELECT
  o.order_id
, date(o.order_date, 'start of month', printf('%+d months', 3 - ((CAST(strftime('%m', o.order_date) AS INTEGER) - 1) % 3)), '-1 day') AS q_end
FROM
 orders o
ORDER BY
  o.order_id ASC
LIMIT 20