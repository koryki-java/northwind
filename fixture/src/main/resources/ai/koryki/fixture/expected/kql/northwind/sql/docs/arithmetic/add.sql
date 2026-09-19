-- add (+): 30 days after the order date.
SELECT
  o.order_id
, o.order_date + INTERVAL '30 day' AS due_date
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY