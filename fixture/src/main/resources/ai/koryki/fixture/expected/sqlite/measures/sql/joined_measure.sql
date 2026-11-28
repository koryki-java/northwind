WITH aggd1 (i1, i2, k1, c1, c2, c3) AS (
SELECT
  DISTINCT od.order_id AS i1
, od.product_id AS i2
, c.country AS k1
, od.unit_price AS c1
, od.quantity AS c2
, aggj1_1.category_id AS c3
FROM
 customers c
  INNER JOIN orders o ON
   c.customer_id = o.customer_id
    INNER JOIN order_details od ON
     o.order_id = od.order_id
      LEFT OUTER JOIN products aggj1_1 ON
       od.product_id = aggj1_1.product_id
)
, aggm1 (k1, v1) AS (
SELECT
  x.k1 AS k1
, sum(CASE WHEN x.c3 = 1 THEN x.c1 * x.c2 END) AS v1
FROM
 aggd1 x
GROUP BY
  x.k1
)
, aggd2 (i1, k1, c1) AS (
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
 , ROUND(NULL, 4) AS v2
 FROM
  aggm1 a
UNION ALL
 SELECT
   a.k1 AS k1
 , ROUND(NULL, 4) AS v1
 , a.v2 AS v2
 FROM
  aggm2 a
)
SELECT
  t.k1 AS country
, max(t.v1) AS beverage_revenue
, max(t.v2) AS freight
FROM
 aggu t
GROUP BY
  t.k1