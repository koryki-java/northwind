-- years_between: whole years from order to shipment.
SELECT
  o.order_id
, CAST(EXTRACT(YEAR FROM age(o.shipped_date, o.order_date)) AS INTEGER) AS years
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY