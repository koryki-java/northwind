-- Regression: an EXISTS filter that cannot be pushed onto a single source
-- (top-level OR) was silently dropped from the rendered SQL, so the EXISTS
-- matched every customer with any order. It must render in the subselect WHERE.
SELECT
  c.company_name
FROM
 customers c
WHERE
  
  EXISTS (
   SELECT
    1
  FROM
   orders o
  WHERE
   c.customer_id = o.customer_id
  AND
   (
     o.freight > 100
    OR
     o.ship_via = 2
   )
  )