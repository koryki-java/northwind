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
  c.country <> 'Brazil'
)
, aggm1 (k1, v1) AS (
SELECT
  x.k1 AS k1
, sum(x.c1) AS v1
FROM
 aggd1 x
GROUP BY
  x.k1
)
, aggd2 (i1, i2, k1, c1) AS (
SELECT
  DISTINCT od.order_id AS i1
, od.product_id AS i2
, c.country AS k1
, od.quantity AS c1
FROM
 customers c
  INNER JOIN orders o ON
   c.customer_id = o.customer_id
    INNER JOIN order_details od ON
     o.order_id = od.order_id
WHERE
  c.country <> 'Brazil'
)
, aggm2 (k1, v2) AS (
SELECT
  x.k1 AS k1
, sum(x.c1) AS v2
FROM
 aggd2 x
GROUP BY
  x.k1
)
, aggu (k1, v1, v2) AS (
 SELECT
   a.k1 AS k1
 , a.v1 AS v1
 , CAST(ROUND(NULL, 0) AS INT) AS v2
 FROM
  aggm1 a
UNION ALL
 SELECT
   a.k1 AS k1
 , CAST(NULL AS DECIMAL(18, 4)) AS v1
 , a.v2 AS v2
 FROM
  aggm2 a
)
SELECT
  t.k1 AS country
, max(t.v1) AS freight
, max(t.v2) AS units
FROM
 aggu t
GROUP BY
  t.k1
HAVING
  max(t.v1) > 10000
ORDER BY
  max(t.v1) DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY