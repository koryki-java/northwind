-- day: the day-of-month of the order date.
SELECT
  o.order_id
, day(o.order_date) AS order_day
FROM
 orders o
ORDER BY
  o.order_id ASC
OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY