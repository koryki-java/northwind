-- A DATE column against a TIMESTAMP literal. TEMPORAL.md states the rule — "the DATE is promoted to
-- midnight (00:00:00)" — so order_date 2022-07-04 read as 2022-07-04 00:00 is NOT >= 12:00, and the
-- answer is 0 rows. Demoting the literal to a date instead would compare 2022-07-04 >= 2022-07-04
-- and answer 1. Nothing in the corpus covered the mixed comparison, so nothing held the engines to
-- the documented rule.
SELECT
  COUNT(*) AS matching_rows
FROM
 orders o
WHERE
  o.order_date >= '2022-07-04 12:00'
 AND
  o.order_id = 10248