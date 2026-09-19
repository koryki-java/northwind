-- date_trunc: truncate the order date to the month.
SELECT
  o.order_id
, (MAKEDATE(YEAR(o.order_date), 1) + INTERVAL (MONTH(o.order_date) - 1) MONTH) AS month_start
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY