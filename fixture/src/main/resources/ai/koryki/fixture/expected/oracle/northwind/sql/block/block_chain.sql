-- a block using an earlier sibling block as its own leading source, the way a SQL CTE may FROM
-- an earlier CTE
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
SELECT
  h.f
, h.i
FROM
 heavy h