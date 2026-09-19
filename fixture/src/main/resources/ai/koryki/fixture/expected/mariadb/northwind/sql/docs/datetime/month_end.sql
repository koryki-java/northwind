-- month_end: last day of the order's month.
SELECT
  o.order_id
, LAST_DAY(o.order_date) AS m_end
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY