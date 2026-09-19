SELECT
  c.contact_name AS h1
, o.order_date AS h2
, od.unit_price AS h3
, cd.customer_desc AS h4
FROM
 customers c
  INNER JOIN orders o ON
   c.customer_id = o.customer_id
    INNER JOIN order_details od ON
     o.order_id = od.order_id
  INNER JOIN customer_customer_demo ccd ON
   c.customer_id = ccd.customer_id
    INNER JOIN customer_demographics cd ON
     ccd.customer_type_id = cd.customer_type_id
WHERE
  od.unit_price > 5
