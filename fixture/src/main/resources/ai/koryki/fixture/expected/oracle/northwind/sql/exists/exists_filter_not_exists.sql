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
  WHERE
   c.customer_id = o.customer_id
  )