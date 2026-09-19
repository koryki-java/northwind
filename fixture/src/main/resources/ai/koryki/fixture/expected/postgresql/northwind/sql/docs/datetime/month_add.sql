-- month_add: one month after the order date.
SELECT
  o.order_id
, (o.order_date + 1 * INTERVAL '1 month') AS next_month
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY