-- year_month: the order's month as a sortable YYYYMM key.
SELECT
  o.order_id
, (year(o.order_date) * 100 + month(o.order_date)) AS order_year_month
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY