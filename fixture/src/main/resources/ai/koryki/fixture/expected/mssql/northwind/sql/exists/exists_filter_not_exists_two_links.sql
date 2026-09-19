-- Find customers without orders
SELECT
  c.contact_name
FROM
 customers c
WHERE
  NOT EXISTS (
   SELECT
    1
  FROM
   orders o
    INNER JOIN order_details od ON
     o.order_id = od.order_id
  WHERE
   c.customer_id = o.customer_id
  )