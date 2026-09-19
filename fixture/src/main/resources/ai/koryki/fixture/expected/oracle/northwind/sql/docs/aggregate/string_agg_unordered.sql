-- The two-argument form leaves the order to the engine. No SQL engine promises one for an
-- aggregate without an explicit sort, so it may differ between dialects, plans and runs -- which is
-- exactly what the markers below record. Use the three-argument form when the order matters; this
-- fixture exists to pin the rendering of the unsorted one.
SELECT
  p.category_id AS category
, LISTAGG(p.product_name, ', ') WITHIN GROUP (ORDER BY p.product_name) AS names
FROM
 products p
GROUP BY
  p.category_id