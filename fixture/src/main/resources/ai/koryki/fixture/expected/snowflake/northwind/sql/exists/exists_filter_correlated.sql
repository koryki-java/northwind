-- Regression: EXISTS filter conjuncts referencing the outer query either
-- NPE'd (outer-alias-only conjunct: c.country) or were silently dropped
-- (mixed-alias conjunct: o.ship_city = c.city). Both must stay as residual
-- filter and render correlated in the subselect WHERE; o.freight is pushed.
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
    o.freight > 10
   AND
    o.ship_city = c.city
   AND
    c.country = 'Germany'
  )