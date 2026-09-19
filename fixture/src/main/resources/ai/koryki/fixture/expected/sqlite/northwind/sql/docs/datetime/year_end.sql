-- year_end: last day of the order's year.
SELECT
  o.order_id
, date(o.order_date, 'start of year', '+1 year', '-1 day') AS y_end
FROM
 orders o
ORDER BY
  o.order_id ASC
LIMIT 20