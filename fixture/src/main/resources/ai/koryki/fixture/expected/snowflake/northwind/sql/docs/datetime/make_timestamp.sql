-- make_timestamp: build a TIMESTAMP from its parts.
SELECT
  o.order_id
, TIMESTAMP_NTZ_FROM_PARTS(2024, 1, 31, 14, 30, 0) AS built
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY