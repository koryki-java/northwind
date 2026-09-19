-- year_begin: first day of the order's year.
SELECT
  o.order_id
, TRUNC(o.order_date, 'YYYY') AS y_begin
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY