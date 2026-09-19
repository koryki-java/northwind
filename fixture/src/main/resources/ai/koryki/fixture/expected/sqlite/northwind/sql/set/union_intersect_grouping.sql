-- Regression: set-operation grouping must survive rendering and the IQL round-trip.
-- (A UNION B) INTERSECT C re-associated to A UNION (B INTERSECT C) when rendered flat,
-- because SQL gives INTERSECT higher precedence.
  SELECT
    c.customer_id AS id
  FROM
   customers c
  WHERE
    c.contact_name LIKE 'A%'
UNION
  SELECT
    c.customer_id AS id
  FROM
   customers c
  WHERE
    c.contact_name LIKE 'B%'
INTERSECT
 SELECT
   c.customer_id AS id
 FROM
  customers c
 WHERE
   c.country = 'Mexico'