-- quarter_begin: first day of the order's quarter.
SELECT
  o.order_id
, date_trunc('quarter', o.order_date) AS q_begin
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY