-- month_add: one month after the order date.
SELECT
  o.order_id
, (ADD_MONTHS(o.order_date, 1) - GREATEST(EXTRACT(DAY FROM ADD_MONTHS(o.order_date, 1)) - EXTRACT(DAY FROM o.order_date), 0)) AS next_month
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY