-- calendar_distance: calendar span from order to shipment (NULL when not yet shipped).
SELECT
  o.order_id
, (CAST(DATE_PART(EPOCH_SECOND, o.order_date) AS VARCHAR) || ';' || CAST(DATE_PART(EPOCH_SECOND, o.shipped_date) AS VARCHAR)) AS span
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY