-- calendar_distance: calendar span from order to shipment (NULL when not yet shipped).
SELECT
  o.order_id
, CONCAT(DATEDIFF_BIG(SECOND, '1970-01-01', o.order_date), ';', DATEDIFF_BIG(SECOND, '1970-01-01', o.shipped_date)) AS span
FROM
 orders o
ORDER BY
  o.order_id ASC
OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY