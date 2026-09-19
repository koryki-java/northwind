-- year_month: the order's month as a sortable YYYYMM key.
SELECT
  o.order_id
, CAST(strftime('%Y%m', o.order_date) AS INTEGER) AS order_year_month
FROM
 orders o
ORDER BY
  o.order_id ASC
LIMIT 20