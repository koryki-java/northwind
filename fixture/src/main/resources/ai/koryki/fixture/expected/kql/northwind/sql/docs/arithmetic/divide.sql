-- divide (/): unit cost of a line item.
SELECT
  od.unit_price / NULLIF(od.quantity, 0) AS unit_cost
FROM
 order_details od