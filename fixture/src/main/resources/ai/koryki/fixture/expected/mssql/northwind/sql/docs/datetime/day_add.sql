-- day_add: seven days after the order date.
SELECT
  o.order_id
, DATEADD(DAY, 7, o.order_date) AS plus_week
FROM
 orders o
ORDER BY
  o.order_id ASC
OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY