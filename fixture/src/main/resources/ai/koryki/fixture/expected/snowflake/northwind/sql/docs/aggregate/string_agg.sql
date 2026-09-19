-- string_agg: the product names of a category, in one cell, in a fixed order.
-- Sorted by product_id rather than by name on purpose: a text sort depends on the engine's
-- collation, so the same names come back in a different order on PostgreSQL and Oracle than on
-- DuckDB. An integer sort is the same everywhere.
SELECT
  p.category_id AS category
, LISTAGG(p.product_name, ', ') WITHIN GROUP (ORDER BY p.product_id) AS names
FROM
 products p
GROUP BY
  p.category_id