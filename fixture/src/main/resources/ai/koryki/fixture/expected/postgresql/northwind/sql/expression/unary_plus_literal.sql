-- Unary plus: positive number literal in filter comparison.
-- Unary plus is a no-op and should render identically to the bare literal.
SELECT
  od.order_id
, od.discount
FROM
 order_details od
WHERE
  od.discount > 0.1