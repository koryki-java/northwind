-- avg: average line-item unit price.
SELECT
  avg(od.unit_price) AS avg_price
FROM
 order_details od