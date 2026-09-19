-- nullif: treat a reorder level of 0 as "not set" rather than as a real threshold.
SELECT
  p.product_id
, nullif(p.reorder_level, 0) AS reorder_level_or_blank
FROM
 products p
ORDER BY
  p.product_id ASC