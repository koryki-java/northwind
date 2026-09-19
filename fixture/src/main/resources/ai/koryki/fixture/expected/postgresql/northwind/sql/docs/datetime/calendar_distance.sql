-- calendar_distance: calendar span from order to shipment (NULL when not yet shipped).
SELECT
  o.order_id
, (CAST(CAST(EXTRACT(EPOCH FROM (o.order_date)) AS BIGINT) AS VARCHAR) || ';' || CAST(CAST(EXTRACT(EPOCH FROM (o.shipped_date)) AS BIGINT) AS VARCHAR)) AS span
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY