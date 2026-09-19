-- BETWEEN's AND belongs to the range and binds tighter than the logical AND, so the trailing
-- predicate is a second condition, not the upper bound. That is the reading PostgreSQL documents:
-- https://www.postgresql.org/docs/current/functions-comparison.html
-- Both must survive — the range test and the bare predicate behind it.
SELECT
  p.product_id
, p.product_name
, p.unit_price
FROM
 products p
WHERE
  p.discontinued <> 0
 AND
  p.unit_price BETWEEN 4 AND 15
ORDER BY
  p.product_id ASC