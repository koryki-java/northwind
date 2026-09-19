-- year_add: one year after the order date.
SELECT
  o.order_id
, min(date(o.order_date, printf('%+d years', 1)), date(o.order_date, 'start of month', printf('%+d months', 1 * 12 + 1), '-1 day')) AS next_year
FROM
 orders o
ORDER BY
  o.order_id ASC
LIMIT 20