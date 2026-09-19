-- Regression: alias reuse between the outer query and a nested EXISTS is legal
-- (each is its own scope), but the push rules resolved aliases by walking the whole
-- subtree last-match-wins, so the outer conjunct o.freight > 10 was moved onto the
-- EXISTS' inner source instead of the outer orders o. It must stay on the outer o.
SELECT
  o.order_id
, c.company_name
FROM
 customers c
  INNER JOIN orders o ON
   c.customer_id = o.customer_id
WHERE
  o.freight > 10
 AND
  
  EXISTS (
   SELECT
    1
  FROM
   orders o
  WHERE
   c.customer_id = o.customer_id
  AND
    o.ship_via = 2
  )
ORDER BY
  o.order_id ASC