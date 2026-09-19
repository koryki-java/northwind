-- years_between: whole years from order to shipment.
SELECT
  o.order_id
, TRUNC(MONTHS_BETWEEN(o.shipped_date, o.order_date) / 12) AS years
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY