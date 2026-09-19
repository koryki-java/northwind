-- week_end: Sunday of the order's week.
SELECT
  o.order_id
, (DATE(o.order_date) - INTERVAL WEEKDAY(o.order_date) DAY + INTERVAL 6 DAY) AS week_close
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY