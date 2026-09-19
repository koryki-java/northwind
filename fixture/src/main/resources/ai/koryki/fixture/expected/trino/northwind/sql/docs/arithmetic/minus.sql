-- minus (-): shipping delay in whole days.
SELECT
  o.order_id
, date_diff('day', o.order_date, o.shipped_date) AS ship_delay
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY