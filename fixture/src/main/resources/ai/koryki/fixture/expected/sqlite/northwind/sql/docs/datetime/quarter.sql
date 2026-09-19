-- quarter: which quarter of the year the order falls in.
SELECT
  o.order_id
, ((CAST(strftime('%m', o.order_date) AS INTEGER) + 2) / 3) AS order_quarter
FROM
 orders o
ORDER BY
  o.order_id ASC
LIMIT 20