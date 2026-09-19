-- year_begin: first day of the order's year.
SELECT
  o.order_id
, date_trunc('year', o.order_date) AS y_begin
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY