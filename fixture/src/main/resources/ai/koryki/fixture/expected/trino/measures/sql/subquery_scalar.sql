WITH q1aggd1 (i1, c1) AS (
SELECT
  DISTINCT x.order_id AS i1
, x.freight AS c1
FROM
 orders x
)
, q1aggm1 (v1) AS (
SELECT
  avg(CAST(x.c1 AS DOUBLE)) AS v1
FROM
 q1aggd1 x
)
, q2aggd1 (i1, k1, c1) AS (
SELECT
  DISTINCT o.order_id AS i1
, c.country AS k1
, o.order_id AS c1
FROM
 customers c
  INNER JOIN orders o ON
   c.customer_id = o.customer_id
WHERE
  o.freight > (
    SELECT
      max(t.v1) AS avg_freight
    FROM
     q1aggm1 t
   )
)
, q2aggm1 (k1, v1) AS (
SELECT
  x.k1 AS k1
, count(x.c1) AS v1
FROM
 q2aggd1 x
GROUP BY
  x.k1
)
SELECT
  t.k1 AS country
, max(t.v1) AS ordercount
FROM
 q2aggm1 t
GROUP BY
  t.k1
ORDER BY
  t.k1 ASC