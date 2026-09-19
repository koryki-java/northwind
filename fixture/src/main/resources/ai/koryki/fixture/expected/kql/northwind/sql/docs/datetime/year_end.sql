-- year_end: last day of the order's year.
SELECT
  o.order_id
, last_day(date_trunc('year', o.order_date) + INTERVAL 11 MONTH) AS y_end
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY