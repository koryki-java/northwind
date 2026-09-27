-- a block joining to an earlier sibling block via a relation, exactly as a SQL CTE joins to an
-- earlier CTE -- the join column customer_id is not in ord's own FETCH, so it must be inferred
-- onto ord (the block actually referenced), not onto cust (the block doing the joining)
WITH ord (f, customer_id) AS (
SELECT
  ROUND(o.freight, 8) AS f
, o.customer_id
FROM
 orders o
)
, cust (contact_name, f) AS (
SELECT
  c.contact_name
, o.f
FROM
 customers c
  INNER JOIN ord o ON
   c.customer_id = o.customer_id
)
SELECT
  x.contact_name
, x.f
FROM
 cust x