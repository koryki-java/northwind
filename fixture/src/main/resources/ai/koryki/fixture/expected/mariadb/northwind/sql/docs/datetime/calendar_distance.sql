-- calendar_distance: calendar span from order to shipment (NULL when not yet shipped).
SELECT
  o.order_id
, CONCAT(UNIX_TIMESTAMP(o.order_date), ';', UNIX_TIMESTAMP(o.shipped_date)) AS span
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY