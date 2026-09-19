-- The same link the way its relation is declared. Belongs beside join_via_reverse_direction:
-- the two are one question asked from either end, and must arrive at the same join and the same
-- rows.
SELECT
  s.company_name AS shipper
, count(o.order_id) AS orders
FROM
 orders o
  INNER JOIN shippers s ON
   o.ship_via = s.shipper_id
GROUP BY
  s.company_name