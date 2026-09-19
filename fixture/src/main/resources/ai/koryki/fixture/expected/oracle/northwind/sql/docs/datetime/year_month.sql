-- year_month: the order's month as a sortable YYYYMM key.
SELECT
  o.order_id
, TO_NUMBER(TO_CHAR(o.order_date, 'YYYYMM')) AS order_year_month
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY