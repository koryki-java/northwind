-- Regression: the window ORDER direction must survive the IQL round-trip —
-- OVER (ORDER ... DESC) re-parsed from serialized IQL used to render ascending,
-- silently reversing rankings and running aggregates.
SELECT
  o.order_id
, o.freight
, rank() OVER ( ORDER BY o.freight DESC) AS freight_rank
FROM
 orders o
WHERE
  o.customer_id = 'ALFKI'
ORDER BY
  o.order_id ASC