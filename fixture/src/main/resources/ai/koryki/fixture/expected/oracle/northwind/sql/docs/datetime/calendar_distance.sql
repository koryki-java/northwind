-- calendar_distance: calendar span from order to shipment (NULL when not yet shipped).
SELECT
  o.order_id
, (TO_CHAR(ROUND((CAST(o.order_date AS DATE) - DATE '1970-01-01') * 86400)) || ';' || TO_CHAR(ROUND((CAST(o.shipped_date AS DATE) - DATE '1970-01-01') * 86400))) AS span
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY