-- quarter_begin: first day of the order's quarter.
SELECT
  o.order_id
, TRUNC(o.order_date, 'Q') AS q_begin
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY