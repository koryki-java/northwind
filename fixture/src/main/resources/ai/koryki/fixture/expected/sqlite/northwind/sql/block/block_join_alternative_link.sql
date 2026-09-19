-- link in alternative order, table first followed by link
WITH ord (f, i) AS (
SELECT
  ROUND(o.freight, 6) AS f
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