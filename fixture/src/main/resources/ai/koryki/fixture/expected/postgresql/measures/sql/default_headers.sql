WITH aggd1 (i1, k1, k2, c1) AS (
SELECT
  DISTINCT o.order_id AS i1
, c.country AS k1
, o.ship_city AS k2
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
, aggm1 (k1, k2, v1) AS (
SELECT
  x.k1 AS k1
, x.k2 AS k2
, sum(x.c1) AS v1
FROM
 aggd1 x
GROUP BY
  x.k1
, x.k2
)
, aggd2 (i1, i2, k1, k2, c1) AS (
SELECT
  DISTINCT od.order_id AS i1
, od.product_id AS i2
, c.country AS k1
, o.ship_city AS k2
, od.quantity AS c1
FROM
 customers c
  INNER JOIN orders o ON
   c.customer_id = o.customer_id
    INNER JOIN order_details od ON
     o.order_id = od.order_id
WHERE
  c.country = 'Germany'
)
, aggm2 (k1, k2, v2) AS (
SELECT
  x.k1 AS k1
, x.k2 AS k2
, sum(x.c1) AS v2
FROM
 aggd2 x
GROUP BY
  x.k1
, x.k2
)
, aggu (k1, k2, v1, v2) AS (
 SELECT
   a.k1 AS k1
 , a.k2 AS k2
 , a.v1 AS v1
 , CAST(NULL AS INTEGER) AS v2
 FROM
  aggm1 a
UNION ALL
 SELECT
   a.k1 AS k1
 , a.k2 AS k2
 , CAST(NULL AS DECIMAL(18, 4)) AS v1
 , a.v2 AS v2
 FROM
  aggm2 a
)
SELECT
  t.k1 AS country
, t.k2 AS city
, max(t.v1) AS total_freight
, max(t.v2) AS u
, max(t.v1) / 2 AS half
FROM
 aggu t
GROUP BY
  t.k1
, t.k2