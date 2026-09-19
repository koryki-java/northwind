-- <> : orders shipped anywhere but one city.
SELECT
  o.order_id
, o.ship_city
FROM
 orders o
WHERE
  o.ship_city <> 'London'
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY