-- make_timestamp: build a TIMESTAMP from its parts.
SELECT
  o.order_id
, STR_TO_DATE(CONCAT(2024, '-', 1, '-', 31, ' ', 14, ':', 30, ':', 0), '%Y-%m-%d %H:%i:%s') AS built
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY