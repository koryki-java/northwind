-- month_begin: first day of the order's month.
SELECT
  o.order_id
, (MAKEDATE(YEAR(o.order_date), 1) + INTERVAL (MONTH(o.order_date) - 1) MONTH) AS m_begin
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY