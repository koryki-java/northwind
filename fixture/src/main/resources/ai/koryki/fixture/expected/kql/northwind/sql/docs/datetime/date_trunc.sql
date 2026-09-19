-- date_trunc: truncate the order date to the month.
SELECT
  o.order_id
, date_trunc('month', o.order_date) AS month_start
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY