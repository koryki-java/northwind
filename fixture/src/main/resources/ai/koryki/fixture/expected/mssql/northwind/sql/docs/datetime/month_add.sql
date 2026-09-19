-- month_add: one month after the order date.
SELECT
  o.order_id
, DATEADD(MONTH, 1, o.order_date) AS next_month
FROM
 orders o
ORDER BY
  o.order_id ASC
OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY