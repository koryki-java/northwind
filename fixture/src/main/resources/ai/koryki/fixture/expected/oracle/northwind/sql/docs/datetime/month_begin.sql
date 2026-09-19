-- month_begin: first day of the order's month.
SELECT
  o.order_id
, TRUNC(o.order_date, 'MM') AS m_begin
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY