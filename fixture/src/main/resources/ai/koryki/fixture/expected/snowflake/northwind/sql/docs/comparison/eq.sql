-- = : orders shipped to a specific city.
SELECT
  o.order_id
, o.ship_city
FROM
 orders o
WHERE
  o.ship_city = 'London'