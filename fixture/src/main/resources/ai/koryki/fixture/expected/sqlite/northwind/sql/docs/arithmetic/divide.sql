-- divide (/): unit cost of a line item.
SELECT
  CAST(od.unit_price AS REAL) / NULLIF(od.quantity, 0) AS unit_cost
FROM
 order_details od