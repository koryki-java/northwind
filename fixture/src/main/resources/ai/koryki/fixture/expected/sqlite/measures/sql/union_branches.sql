 SELECT
   'total' AS metric
 , sum(o.freight) AS amount
 FROM
  orders o
 GROUP BY
   'total'
UNION ALL
 SELECT
   'big' AS metric
 , sum(CASE WHEN o.freight > 100 THEN o.freight END) AS amount
 FROM
  orders o
 GROUP BY
   'big'