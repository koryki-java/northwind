-- year_add: one year after the order date.
SELECT
  o.order_id
, (ADD_MONTHS(o.order_date, 1 * 12) - GREATEST(EXTRACT(DAY FROM ADD_MONTHS(o.order_date, 1 * 12)) - EXTRACT(DAY FROM o.order_date), 0)) AS next_year
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY