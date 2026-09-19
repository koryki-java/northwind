-- Regression: a comparison followed by a bare boolean predicate. The pair alternative of
-- unary_logical_expression — meant for BETWEEN — used to apply after ANY operator, so
-- `unit_price > 10 AND discontinued` bound `discontinued` as a third operand of `>`, and the
-- template `{0} > {1}` never rendered it. The predicate vanished without a violation or a warning,
-- and the filter returned every product over 10 — discontinued or not.
SELECT
  p.product_id
, p.product_name
, p.unit_price
FROM
 products p
WHERE
  p.discontinued <> 0
 AND
  p.unit_price > 10
ORDER BY
  p.product_id ASC