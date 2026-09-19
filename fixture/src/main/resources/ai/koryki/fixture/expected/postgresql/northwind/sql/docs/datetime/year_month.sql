-- year_month: the order's month as a sortable YYYYMM key.
SELECT
  o.order_id
, CAST(EXTRACT(YEAR FROM o.order_date) * 100 + EXTRACT(MONTH FROM o.order_date) AS INTEGER) AS order_year_month
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY