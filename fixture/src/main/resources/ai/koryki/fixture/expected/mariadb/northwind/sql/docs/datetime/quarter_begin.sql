-- quarter_begin: first day of the order's quarter.
SELECT
  o.order_id
, (MAKEDATE(YEAR(o.order_date), 1) + INTERVAL (QUARTER(o.order_date) - 1) * 3 MONTH) AS q_begin
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY