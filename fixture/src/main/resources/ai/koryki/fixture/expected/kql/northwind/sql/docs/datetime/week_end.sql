-- week_end: Sunday of the order's week.
SELECT
  o.order_id
, CAST(date_trunc('week', o.order_date) + INTERVAL 6 DAY AS DATE) AS week_close
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY