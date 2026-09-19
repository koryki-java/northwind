-- quarter: which quarter of the year the order falls in.
SELECT
  o.order_id
, EXTRACT(QUARTER FROM o.order_date) AS order_quarter
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY