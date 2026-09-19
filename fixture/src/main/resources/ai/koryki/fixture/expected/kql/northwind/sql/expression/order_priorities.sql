-- Ranked freight per country - fetch-item ordering with explicit sort priorities.
-- Locks two behaviors: the ORDER BY clause must be sorted by the explicit
-- priority numbers (DESC 1 before ASC 2), not by fetch position, and the order
-- expressions are the same instances as the output expressions (metadata
-- correlation for result headers).
SELECT
  o.ship_country AS country
, sum(o.freight) AS freight
FROM
 orders o
GROUP BY
  o.ship_country
ORDER BY
  sum(o.freight) DESC
, o.ship_country ASC