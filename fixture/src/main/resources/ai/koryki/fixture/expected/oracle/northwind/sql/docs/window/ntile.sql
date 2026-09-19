-- ntile: split the orders into four groups of near-equal size by freight — quartiles.
SELECT
  o.order_id
, o.freight
, ntile(4) OVER ( ORDER BY o.freight) AS quartile
FROM
 orders o
WHERE
  o.ship_country = 'France'