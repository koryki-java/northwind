-- percent_rank: where each order's freight sits between the lightest (0) and the heaviest (1) shipped to France.
SELECT
  o.order_id
, o.freight
, percent_rank() OVER ( ORDER BY o.freight) AS freight_percentile
FROM
 orders o
WHERE
  o.ship_country = 'France'