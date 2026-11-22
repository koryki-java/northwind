SELECT
  c.country AS country
, count(o.order_id) AS ordercount
FROM
 customers c
  INNER JOIN orders o ON
   c.customer_id = o.customer_id
WHERE
  o.freight > (
    SELECT
      avg(CAST(x.freight AS DOUBLE)) AS avg_freight
    FROM
     orders x
   )
GROUP BY
  c.country
ORDER BY
  c.country ASC