-- add (+): 30 days after the order date.
SELECT
  o.order_id
, date(o.order_date, '+30 days') AS due_date
FROM
 orders o
ORDER BY
  o.order_id ASC
LIMIT 20