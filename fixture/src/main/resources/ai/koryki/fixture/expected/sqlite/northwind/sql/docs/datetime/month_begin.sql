-- month_begin: first day of the order's month.
SELECT
  o.order_id
, date(o.order_date, 'start of month') AS m_begin
FROM
 orders o
ORDER BY
  o.order_id ASC
LIMIT 20