-- Find customers contacts and orderdate
-- Use one non optional join
SELECT
  c.contact_name
, o.order_date
FROM
 customers c
  LEFT OUTER JOIN orders o ON
   c.customer_id = o.customer_id
