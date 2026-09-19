-- Regression: an EXISTS filter with two pushable conjuncts crashed with
-- UnsupportedOperationException (fixed-size children list, exists filter
-- skipped Normalizer). Both conjuncts must be pushed onto source o.
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
    o.ship_via = 2
   AND
    o.freight > 10
  )