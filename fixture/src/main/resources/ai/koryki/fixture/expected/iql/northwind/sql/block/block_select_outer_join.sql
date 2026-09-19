WITH ord (freight, customer_id) AS (
SELECT
  o.freight
, o.customer_id
FROM
 orders o
)
, cust (contact_name, i) AS (
SELECT
  c.contact_name
, c.customer_id AS i
FROM
 customers c
)
SELECT
  o.freight
, c.contact_name
FROM
 ord o
  LEFT OUTER JOIN cust c ON
   o.customer_id = c.i
