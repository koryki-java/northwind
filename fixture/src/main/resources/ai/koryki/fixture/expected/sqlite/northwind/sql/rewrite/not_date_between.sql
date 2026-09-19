-- NOT BETWEEN — BETWEEN rewritten first, NOT wraps the half-open AND
SELECT
  o.order_id
, o.order_date
FROM
 orders o
WHERE
   NOT (o.order_date >= '2022-01-01')
  OR
   NOT (o.order_date < '2023-01-01')