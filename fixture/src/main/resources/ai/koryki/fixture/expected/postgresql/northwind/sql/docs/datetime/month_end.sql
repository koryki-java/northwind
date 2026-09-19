-- month_end: last day of the order's month.
SELECT
  o.order_id
, CAST(date_trunc('month', o.order_date) + INTERVAL '1 month - 1 day' AS DATE) AS m_end
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY