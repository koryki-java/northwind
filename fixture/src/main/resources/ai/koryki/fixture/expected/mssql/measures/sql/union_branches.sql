WITH q1aggd1 (i1, k1, c1) AS (
SELECT
  DISTINCT o.order_id AS i1
, 'total' AS k1
, o.freight AS c1
FROM
 orders o
)
, q1aggm1 (k1, v1) AS (
SELECT
  x.k1 AS k1
, sum(x.c1) AS v1
FROM
 q1aggd1 x
GROUP BY
  x.k1
)
, q2aggd1 (i1, k1, c1) AS (
SELECT
  DISTINCT o.order_id AS i1
, 'big' AS k1
, o.freight AS c1
FROM
 orders o
)
, q2aggm1 (k1, v1) AS (
SELECT
  x.k1 AS k1
, sum(CASE WHEN x.c1 > 100 THEN x.c1 END) AS v1
FROM
 q2aggd1 x
GROUP BY
  x.k1
)
 SELECT
   t.k1 AS metric
 , max(t.v1) AS amount
 FROM
  q1aggm1 t
 GROUP BY
   t.k1
UNION ALL
 SELECT
   t.k1 AS metric
 , max(t.v1) AS amount
 FROM
  q2aggm1 t
 GROUP BY
   t.k1