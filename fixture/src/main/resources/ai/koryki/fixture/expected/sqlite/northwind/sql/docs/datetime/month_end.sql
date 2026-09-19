-- month_end: last day of the order's month.
SELECT
  o.order_id
, date(o.order_date, 'start of month', '+1 month', '-1 day') AS m_end
FROM
 orders o
ORDER BY
  o.order_id ASC
LIMIT 20