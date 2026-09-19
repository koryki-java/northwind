-- add (+): 30 days after the order date.
SELECT
  o.order_id
, DATEADD(DAY, 30, o.order_date) AS due_date
FROM
 orders o
ORDER BY
  o.order_id ASC
OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY