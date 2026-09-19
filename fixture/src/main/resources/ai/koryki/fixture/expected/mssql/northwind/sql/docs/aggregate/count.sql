-- count: number of orders.
SELECT
  count(o.order_id) AS order_count
FROM
 orders o