-- years_between: whole years from order to shipment.
SELECT
  o.order_id
, (DATEDIFF(YEAR, o.order_date, o.shipped_date) - CASE WHEN DATEADD(YEAR, DATEDIFF(YEAR, o.order_date, o.shipped_date), o.order_date) > o.shipped_date THEN 1 ELSE 0 END) AS years
FROM
 orders o
ORDER BY
  o.order_id ASC
OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY