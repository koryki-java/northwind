-- OR : orders shipped to either of two cities.
SELECT
  o.order_id
, o.ship_city
FROM
 orders o
WHERE
   o.ship_city = 'London'
  OR
   o.ship_city = 'Paris'