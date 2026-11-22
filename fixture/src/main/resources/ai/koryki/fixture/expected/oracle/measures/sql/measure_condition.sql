WITH aggd1 (i1, k1, c1) AS (
SELECT
  DISTINCT o.order_id AS i1
, c.country AS k1
, o.freight AS c1
FROM
 customers c
  INNER JOIN orders o ON
   c.customer_id = o.customer_id
    INNER JOIN order_details od ON
     o.order_id = od.order_id
WHERE
  c.country = 'Germany'
)
, aggm1 (k1, v1, v2) AS (
SELECT
  x.k1 AS k1
, sum(CASE WHEN x.c1 > 100 THEN x.c1 END) AS v1
, sum(x.c1) AS v2
FROM
 aggd1 x
GROUP BY
  x.k1
)
SELECT
  t.k1 AS country
, max(t.v1) AS big
, max(t.v2) AS total
FROM
 aggm1 t
GROUP BY
  t.k1