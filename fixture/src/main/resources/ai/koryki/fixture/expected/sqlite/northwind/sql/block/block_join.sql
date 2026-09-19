-- link in regular order, link first followed by table
WITH ord (f, i) AS (
SELECT
  ROUND(o.freight, 8) AS f
, o.customer_id AS i
FROM
 orders o
)
SELECT
  c.contact_name
, o.f
FROM
 customers c
  INNER JOIN ord o ON
   c.customer_id = o.i