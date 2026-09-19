-- Regression: explicit arithmetic grouping must survive the IQL round-trip —
-- (unit_price + 1) * quantity re-parsed from serialized IQL used to render
-- unit_price + 1 * quantity, silently changing the value.
SELECT
  od.order_id
, od.product_id
, (od.unit_price + 1) * od.quantity AS adjusted
FROM
 order_details od
WHERE
  od.quantity > 100
ORDER BY
  od.order_id ASC
, od.product_id ASC