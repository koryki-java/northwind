-- IN : orders shipped to any of a set of cities.
SELECT
  o.order_id
, o.ship_city
FROM
 orders o
WHERE
  o.ship_city IN ('London', 'Paris')