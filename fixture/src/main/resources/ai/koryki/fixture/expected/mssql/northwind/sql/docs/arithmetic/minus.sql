-- minus (-): shipping delay in whole days.
SELECT
  o.order_id
, DATEDIFF(DAY, o.order_date, o.shipped_date) AS ship_delay
FROM
 orders o
ORDER BY
  o.order_id ASC
OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY