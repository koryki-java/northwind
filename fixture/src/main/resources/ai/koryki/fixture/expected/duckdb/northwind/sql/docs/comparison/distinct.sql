-- DISTINCT : null-safe difference — a missing value counts as a difference, and two missing values
-- count as equal. The same distinctness FETCH DISTINCT uses when it collapses duplicate rows.
-- Negated here to ask the opposite: which French orders ship to the customer's own region? Both are
-- blank for every French customer, so <> would return nothing — two unknowns are never "different".
SELECT
  c.customer_id
, c.region AS customer_region
, o.ship_region AS order_region
FROM
 customers c
  INNER JOIN orders o ON
   c.customer_id = o.customer_id
WHERE
  c.country = 'France'
 AND
  c.region IS NOT DISTINCT FROM o.ship_region