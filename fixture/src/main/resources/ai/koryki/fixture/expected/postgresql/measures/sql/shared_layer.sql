WITH aggd1 (i1, k1, c1, c2) AS (
SELECT
  DISTINCT o.order_id AS i1
, c.country AS k1
, o.freight AS c1
, o.order_id AS c2
FROM
 customers c
  INNER JOIN orders o ON
   c.customer_id = o.customer_id
    INNER JOIN order_details od ON
     o.order_id = od.order_id
)
, aggm1 (k1, v1, v2, v3) AS (
SELECT
  x.k1 AS k1
, sum(x.c1) AS v1
, count(x.c2) AS v2
, avg(x.c1) AS v3
FROM
 aggd1 x
GROUP BY
  x.k1
)
SELECT
  t.k1 AS country
, max(t.v1) AS freight
, max(t.v2) AS orders
, round(CAST(max(t.v3) AS numeric), 2) AS average
FROM
 aggm1 t
GROUP BY
  t.k1