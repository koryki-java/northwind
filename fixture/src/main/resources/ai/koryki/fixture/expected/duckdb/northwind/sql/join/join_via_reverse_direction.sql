-- A link written against the direction its relation is declared in. fk_orders_shippers is
-- orders.ship_via -> shippers.shipper_id, and naming shippers first must still join ship_via to
-- shipper_id. Almost every relation hides a mistake here, because a foreign key usually carries
-- the name of the column it points at; this is the one in Northwind that does not.
SELECT
  s.company_name AS shipper
, count(o.order_id) AS orders
FROM
 shippers s
  INNER JOIN orders o ON
   s.shipper_id = o.ship_via
GROUP BY
  s.company_name