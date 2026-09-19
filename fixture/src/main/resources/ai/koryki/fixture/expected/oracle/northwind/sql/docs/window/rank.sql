-- rank: position by freight, heaviest first. Equal freights share a rank and the next one skips.
SELECT
  o.order_id
, o.freight
, rank() OVER ( ORDER BY o.freight DESC) AS freight_rank
FROM
 orders o
WHERE
  o.ship_country = 'France'