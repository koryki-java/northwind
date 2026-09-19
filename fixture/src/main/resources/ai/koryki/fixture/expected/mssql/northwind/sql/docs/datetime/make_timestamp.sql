-- make_timestamp: build a TIMESTAMP from its parts.
SELECT
  o.order_id
, DATETIME2FROMPARTS(2024, 1, 31, 14, 30, 0, 0, 0) AS built
FROM
 orders o
ORDER BY
  o.order_id ASC
OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY