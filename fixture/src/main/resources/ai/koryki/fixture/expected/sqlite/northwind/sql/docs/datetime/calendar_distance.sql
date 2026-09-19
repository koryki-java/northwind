-- calendar_distance: calendar span from order to shipment (NULL when not yet shipped).
SELECT
  o.order_id
, (CAST(CAST(strftime('%s', o.order_date) AS INTEGER) AS VARCHAR) || ';' || CAST(CAST(strftime('%s', o.shipped_date) AS INTEGER) AS VARCHAR)) AS span
FROM
 orders o
ORDER BY
  o.order_id ASC
LIMIT 20