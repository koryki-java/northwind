WITH aggd1 (i1, i2, k1, c1, c2, c3) AS (
SELECT
  DISTINCT od.order_id AS i1
, od.product_id AS i2
, p.category_id AS k1
, od.unit_price AS c1
, od.quantity AS c2
, aggj1_2.country AS c3
FROM
 products p
  INNER JOIN order_details od ON
   p.product_id = od.product_id
    LEFT OUTER JOIN orders aggj1_1 ON
     od.order_id = aggj1_1.order_id
      LEFT OUTER JOIN customers aggj1_2 ON
       aggj1_1.customer_id = aggj1_2.customer_id
)
, aggm1 (k1, v1, v2) AS (
SELECT
  x.k1 AS k1
, sum(CASE WHEN x.c3 = 'Germany' THEN x.c1 * x.c2 END) AS v1
, sum(x.c2) AS v2
FROM
 aggd1 x
GROUP BY
  x.k1
)
SELECT
  t.k1 AS category
, max(t.v1) AS germany
, max(t.v2) AS units
FROM
 aggm1 t
GROUP BY
  t.k1