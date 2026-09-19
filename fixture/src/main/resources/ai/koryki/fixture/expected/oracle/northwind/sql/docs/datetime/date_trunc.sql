-- date_trunc: truncate the order date to the month.
SELECT
  o.order_id
, TRUNC(o.order_date, 'MM') AS month_start
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY