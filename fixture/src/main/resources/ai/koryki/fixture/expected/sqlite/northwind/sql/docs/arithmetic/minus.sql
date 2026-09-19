-- minus (-): shipping delay in whole days.
SELECT
  o.order_id
, CAST(julianday(o.shipped_date) - julianday(o.order_date) AS INTEGER) AS ship_delay
FROM
 orders o
ORDER BY
  o.order_id ASC
LIMIT 20