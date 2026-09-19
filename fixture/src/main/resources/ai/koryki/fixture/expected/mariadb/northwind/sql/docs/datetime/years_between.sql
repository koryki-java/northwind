-- years_between: whole years from order to shipment.
SELECT
  o.order_id
, TIMESTAMPDIFF(YEAR, o.order_date, o.shipped_date) AS years
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY