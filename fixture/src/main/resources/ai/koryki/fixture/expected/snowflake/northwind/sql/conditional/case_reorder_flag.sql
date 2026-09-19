-- Flag products that need reordering: on-hand stock below the reorder level (case as a two-way
-- ternary — case(condition, then, else)).
SELECT
  p.product_id
, p.product_name
, CASE WHEN p.units_in_stock < p.reorder_level THEN 'reorder' ELSE 'ok' END AS stock_status
FROM
 products p
ORDER BY
  p.product_id ASC