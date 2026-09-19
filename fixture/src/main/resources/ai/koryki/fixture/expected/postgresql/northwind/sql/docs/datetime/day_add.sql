-- day_add: seven days after the order date.
SELECT
  o.order_id
, (o.order_date + 7 * INTERVAL '1 day') AS plus_week
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY