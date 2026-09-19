-- month_begin: first day of the order's month.
SELECT
  o.order_id
, DATEADD(MONTH, DATEDIFF(MONTH, 0, o.order_date), 0) AS m_begin
FROM
 orders o
ORDER BY
  o.order_id ASC
OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY