-- week_end: Sunday of the order's week.
SELECT
  o.order_id
, (TRUNC(o.order_date, 'IW') + 6) AS week_close
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY