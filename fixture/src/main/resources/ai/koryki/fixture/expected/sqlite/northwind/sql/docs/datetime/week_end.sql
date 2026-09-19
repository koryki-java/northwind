-- week_end: Sunday of the order's week.
SELECT
  o.order_id
, date(o.order_date, 'weekday 0') AS week_close
FROM
 orders o
ORDER BY
  o.order_id ASC
LIMIT 20