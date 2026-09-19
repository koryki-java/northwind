-- date_trunc: truncate the order date to the month.
SELECT
  o.order_id
, DATEADD(MONTH, DATEDIFF(MONTH, 0, o.order_date), 0) AS month_start
FROM
 orders o
ORDER BY
  o.order_id ASC
OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY