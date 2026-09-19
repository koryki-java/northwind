-- week_end: Sunday of the order's week.
SELECT
  o.order_id
, DATEADD(day, 6 - (DATEDIFF(day, 0, o.order_date) % 7), CAST(o.order_date AS DATE)) AS week_close
FROM
 orders o
ORDER BY
  o.order_id ASC
OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY