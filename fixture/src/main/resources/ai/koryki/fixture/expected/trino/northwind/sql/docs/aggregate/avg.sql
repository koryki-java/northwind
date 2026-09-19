-- avg: average line-item unit price.
SELECT
  avg(CAST(od.unit_price AS DOUBLE)) AS avg_price
FROM
 order_details od