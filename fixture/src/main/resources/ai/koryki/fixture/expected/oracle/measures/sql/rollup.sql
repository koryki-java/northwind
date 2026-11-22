WITH aggd1 (i1, k1, k2, c1) AS (
SELECT
  DISTINCT o.order_id AS i1
, c.country AS k1
, c.region AS k2
, o.freight AS c1
FROM
 customers c
  INNER JOIN orders o ON
   c.customer_id = o.customer_id
    INNER JOIN order_details od ON
     o.order_id = od.order_id
)
, aggm1s2 (k1, k2, v1) AS (
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
, aggm1s1 (k1, v1) AS (
SELECT
  x.k1 AS k1
, sum(x.c1) AS v1
FROM
 aggd1 x
GROUP BY
  x.k1
)
, aggm1s0 (v1) AS (
SELECT
  sum(x.c1) AS v1
FROM
 aggd1 x
)
, aggd2 (i1, i2, k1, k2, c1) AS (
SELECT
  DISTINCT od.order_id AS i1
, od.product_id AS i2
, c.country AS k1
, c.region AS k2
, od.quantity AS c1
FROM
 customers c
  INNER JOIN orders o ON
   c.customer_id = o.customer_id
    INNER JOIN order_details od ON
     o.order_id = od.order_id
)
, aggm2s2 (k1, k2, v2) AS (
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
, aggm2s1 (k1, v2) AS (
SELECT
  x.k1 AS k1
, sum(x.c1) AS v2
FROM
 aggd2 x
GROUP BY
  x.k1
)
, aggm2s0 (v2) AS (
SELECT
  sum(x.c1) AS v2
FROM
 aggd2 x
)
, aggu (g, k1, k2, v1, v2) AS (
     SELECT
       2 AS g
     , a.k1 AS k1
     , a.k2 AS k2
     , a.v1 AS v1
     , CAST(NULL AS INTEGER) AS v2
     FROM
      aggm1s2 a
UNION ALL
     SELECT
       2 AS g
     , a.k1 AS k1
     , a.k2 AS k2
     , CAST(NULL AS DECIMAL(18, 4)) AS v1
     , a.v2 AS v2
     FROM
      aggm2s2 a
UNION ALL
    SELECT
      1 AS g
    , a.k1 AS k1
    , TO_CHAR(CAST(NULL AS INTEGER), 'TM9', 'NLS_NUMERIC_CHARACTERS = ''.,''') AS k2
    , a.v1 AS v1
    , CAST(NULL AS INTEGER) AS v2
    FROM
     aggm1s1 a
UNION ALL
   SELECT
     1 AS g
   , a.k1 AS k1
   , TO_CHAR(CAST(NULL AS INTEGER), 'TM9', 'NLS_NUMERIC_CHARACTERS = ''.,''') AS k2
   , CAST(NULL AS DECIMAL(18, 4)) AS v1
   , a.v2 AS v2
   FROM
    aggm2s1 a
UNION ALL
  SELECT
    0 AS g
  , TO_CHAR(CAST(NULL AS INTEGER), 'TM9', 'NLS_NUMERIC_CHARACTERS = ''.,''') AS k1
  , TO_CHAR(CAST(NULL AS INTEGER), 'TM9', 'NLS_NUMERIC_CHARACTERS = ''.,''') AS k2
  , a.v1 AS v1
  , CAST(NULL AS INTEGER) AS v2
  FROM
   aggm1s0 a
UNION ALL
 SELECT
   0 AS g
 , TO_CHAR(CAST(NULL AS INTEGER), 'TM9', 'NLS_NUMERIC_CHARACTERS = ''.,''') AS k1
 , TO_CHAR(CAST(NULL AS INTEGER), 'TM9', 'NLS_NUMERIC_CHARACTERS = ''.,''') AS k2
 , CAST(NULL AS DECIMAL(18, 4)) AS v1
 , a.v2 AS v2
 FROM
  aggm2s0 a
)
, aggr (g, k1, k2, v1, v2) AS (
SELECT
  t.g AS g
, t.k1 AS k1
, t.k2 AS k2
, max(t.v1) AS v1
, max(t.v2) AS v2
FROM
 aggu t
GROUP BY
  t.g
, t.k1
, t.k2
)
SELECT
  r.k1 AS country
, r.k2 AS region
, r.v1 AS freight
, r.v2 AS units
FROM
 aggr r
ORDER BY
  r.k1 ASC
, r.k2 ASC