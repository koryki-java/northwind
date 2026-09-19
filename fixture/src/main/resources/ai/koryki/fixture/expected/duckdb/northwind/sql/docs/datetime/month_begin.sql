-- month_begin: first day of the order's month.
SELECT
  o.order_id
, date_trunc('month', o.order_date) AS m_begin
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY