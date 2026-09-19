-- sum: total quantity ordered across all lines.
SELECT
  sum(od.quantity) AS total_quantity
FROM
 order_details od