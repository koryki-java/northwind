-- week_end: Sunday of the order's week.
SELECT
  o.order_id
, DATEADD(day, 7 - DAYOFWEEKISO(o.order_date), o.order_date) AS week_close
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY