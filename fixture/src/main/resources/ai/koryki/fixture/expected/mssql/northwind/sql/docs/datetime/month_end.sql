-- month_end: last day of the order's month.
SELECT
  o.order_id
, EOMONTH(o.order_date) AS m_end
FROM
 orders o
ORDER BY
  o.order_id ASC
OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY