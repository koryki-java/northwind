-- log10: base-10 logarithm.
SELECT
  o.order_id
, log10(1000) AS base_ten_log
FROM
 orders o
ORDER BY
  o.order_id ASC
LIMIT 20