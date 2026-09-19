-- NOT BETWEEN — BETWEEN rewritten first, NOT wraps the half-open AND
SELECT
  o.order_id
, o.order_date
FROM
 orders o
WHERE
   NOT (o.order_date >= CAST('2022-01-01' AS DATE))
  OR
   NOT (o.order_date < CAST('2023-01-01' AS DATE))