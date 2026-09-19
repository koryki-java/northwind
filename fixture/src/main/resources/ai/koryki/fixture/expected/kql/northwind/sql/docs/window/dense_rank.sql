-- dense_rank: like rank, but the numbering has no gaps after a tie.
SELECT
  o.order_id
, o.freight
, dense_rank() OVER ( ORDER BY o.freight DESC) AS freight_rank
FROM
 orders o
WHERE
  o.ship_country = 'France'