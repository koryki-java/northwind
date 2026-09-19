-- month_end: last day of the order's month.
SELECT
  o.order_id
, last_day(o.order_date) AS m_end
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY