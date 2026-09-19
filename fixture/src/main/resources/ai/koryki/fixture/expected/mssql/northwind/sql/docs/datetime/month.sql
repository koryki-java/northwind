-- month: the month component of the order date.
SELECT
  o.order_id
, month(o.order_date) AS order_month
FROM
 orders o
ORDER BY
  o.order_id ASC
OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY