-- month: the month component of the order date.
SELECT
  o.order_id
, EXTRACT(MONTH FROM o.order_date) AS order_month
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY