-- Bucket each order's freight cost into a shipping tier — a searched CASE with two predicates
-- (case(cond1, result1, cond2, result2, else)).
SELECT
  o.order_id
, o.freight
, CASE WHEN o.freight > 100 THEN 'premium' WHEN o.freight > 30 THEN 'standard' ELSE 'economy' END AS freight_tier
FROM
 orders o
WHERE
  o.order_id < 10253
ORDER BY
  o.order_id ASC