SELECT
  c.contact_name
, o.order_date
, d.unit_price
FROM
 customers c
  INNER JOIN orders o ON
   c.customer_id = o.customer_id
    LEFT OUTER JOIN order_details d ON
     o.order_id = d.order_id
    AND
     d.unit_price > 5
WHERE
    c.contact_name LIKE 'A%'
   AND
    c.contact_name LIKE 'B%'
   AND
    c.contact_name LIKE 'C%'
  OR
   c.contact_name LIKE 'D%'
