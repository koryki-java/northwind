WITH aggd1 (i1, c1) AS (
SELECT
  DISTINCT o.order_id AS i1
, o.freight AS c1
FROM
 customers c
  INNER JOIN orders o ON
   c.customer_id = o.customer_id
    INNER JOIN order_details od ON
     o.order_id = od.order_id
)
, aggm1 (v1) AS (
SELECT
  sum(x.c1) AS v1
FROM
 aggd1 x
)
, aggd2 (i1, i2, c1, c2) AS (
SELECT
  DISTINCT od.order_id AS i1
, od.product_id AS i2
, od.quantity AS c1
, od.unit_price AS c2
FROM
 customers c
  INNER JOIN orders o ON
   c.customer_id = o.customer_id
    INNER JOIN order_details od ON
     o.order_id = od.order_id
)
, aggm2 (v2, v3) AS (
SELECT
  sum(x.c1) AS v2
, sum(x.c2 * x.c1) AS v3
FROM
 aggd2 x
)
, aggu (v1, v2, v3) AS (
 SELECT
   a.v1 AS v1
 , CAST(NULL AS INTEGER) AS v2
 , CAST(NULL AS DECIMAL(18, 4)) AS v3
 FROM
  aggm1 a
UNION ALL
 SELECT
   CAST(NULL AS DECIMAL(18, 4)) AS v1
 , a.v2 AS v2
 , a.v3 AS v3
 FROM
  aggm2 a
)
SELECT
  max(t.v1) AS freight
, max(t.v2) AS units
, max(t.v3) AS revenue
FROM
 aggu t