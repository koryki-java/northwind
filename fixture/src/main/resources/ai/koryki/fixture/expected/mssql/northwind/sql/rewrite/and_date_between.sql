-- AND with two DATE BETWEENs — both upper bounds rewritten independently.
-- The window is deliberately two months wide: required_date trails order_date by roughly a month,
-- so a single-month window would AND itself into emptiness (no order_date/required_date pair ever
-- both fall in the same 31 days). Two months gives real overlap without forcing the original
-- author's mistaken "first half of the dataset's first year" window, which predates any order.
SELECT
  o.order_id
, o.order_date
, o.required_date
FROM
 orders o
WHERE
  o.required_date >= CAST('2023-02-01' AS DATE)
 AND
  o.required_date < CAST('2023-04-01' AS DATE)
 AND
  o.order_date >= CAST('2023-02-01' AS DATE)
 AND
  o.order_date < CAST('2023-04-01' AS DATE)