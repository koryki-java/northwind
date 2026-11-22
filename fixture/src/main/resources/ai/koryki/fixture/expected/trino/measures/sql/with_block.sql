WITH countryfreight (country, freight) AS (
SELECT
  c.country AS country
, sum(o.freight) AS freight
FROM
 customers c
  INNER JOIN orders o ON
   c.customer_id = o.customer_id
GROUP BY
  c.country
)
SELECT
  avg(CAST(f.freight AS DOUBLE)) AS avgfreight
, max(f.freight) AS maxfreight
FROM
 countryfreight f