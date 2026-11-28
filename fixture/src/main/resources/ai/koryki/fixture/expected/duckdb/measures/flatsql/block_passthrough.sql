SELECT
  o.ship_country AS country
, sum(o.freight) AS freight
, count(o.order_id) AS orders
FROM
 orders o
GROUP BY
  o.ship_country
ORDER BY
  o.ship_country ASC
