-- year_begin: first day of the order's year.
SELECT
  o.order_id
, date(o.order_date, 'start of year') AS y_begin
FROM
 orders o
ORDER BY
  o.order_id ASC
LIMIT 20