-- a chain three blocks deep: each block may only use blocks already defined before it, exactly
-- like a SQL WITH-list where a later CTE may FROM any earlier one
WITH ord (f, i) AS (
SELECT
  CAST(o.freight AS DECIMAL(16, 8)) AS f
, o.customer_id AS i
FROM
 orders o
)
, heavy (f, i) AS (
SELECT
  x.f
, x.i
FROM
 ord x
WHERE
  x.f > 50
)
, heaviest (f, i) AS (
SELECT
  y.f
, y.i
FROM
 heavy y
WHERE
  y.f > 100
)
SELECT
  z.f
, z.i
FROM
 heaviest z