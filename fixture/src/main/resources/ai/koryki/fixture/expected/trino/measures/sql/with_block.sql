WITH aggd1 (i1, k1, c1) AS (
SELECT
  DISTINCT o.order_id AS i1
, c.country AS k1
, o.freight AS c1
FROM
 customers c
  INNER JOIN orders o ON
   c.customer_id = o.customer_id
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
, countryfreight (country, freight) AS (
SELECT
  t.k1 AS country
, max(t.v1) AS freight
FROM
 aggm1 t
GROUP BY
  t.k1
)
SELECT
  avg(CAST(f.freight AS DOUBLE)) AS avgfreight
, max(f.freight) AS maxfreight
FROM
 countryfreight f