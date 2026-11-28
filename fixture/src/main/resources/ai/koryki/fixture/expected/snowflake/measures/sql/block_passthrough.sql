WITH shipped (country, freight, orders) AS (
SELECT
  o.ship_country AS country
, o.freight AS freight
, o.order_id AS orders
FROM
 orders o
)
, passed (country, freight, orders) AS (
SELECT
  s.country AS country
, s.freight AS freight
, s.orders AS orders
FROM
 shipped s
)
SELECT
  p.country AS country
, sum(p.freight) AS freight
, count(p.orders) AS orders
FROM
 passed p
GROUP BY
  p.country
ORDER BY
  p.country ASC