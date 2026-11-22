WITH aggd1 (i1, k1, c1, c2) AS (
SELECT
  DISTINCT o.order_id AS i1
, c.company_name AS k1
, o.order_id AS c1
, o.freight AS c2
FROM
 customers c
  LEFT OUTER JOIN orders o ON
   c.customer_id = o.customer_id
)
, aggm1 (k1, v1, v2) AS (
SELECT
  x.k1 AS k1
, count(x.c1) AS v1
, sum(x.c2) AS v2
FROM
 aggd1 x
GROUP BY
  x.k1
)
SELECT
  t.k1 AS company_name
, max(t.v1) AS ordercount
, max(t.v2) AS freight
FROM
 aggm1 t
GROUP BY
  t.k1