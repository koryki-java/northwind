-- quarter: which quarter of the year the order falls in.
SELECT
  o.order_id
, DATEPART(quarter, o.order_date) AS order_quarter
FROM
 orders o
ORDER BY
  o.order_id ASC
OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY