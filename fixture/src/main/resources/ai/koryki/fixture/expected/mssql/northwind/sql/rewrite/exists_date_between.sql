-- DATE BETWEEN inside NOT EXISTS — rewrite must reach into the exists filter
SELECT
  c.company_name
FROM
 customers c
WHERE
  NOT EXISTS (
   SELECT
    1
  FROM
   orders o
  WHERE
   c.customer_id = o.customer_id
  AND
    o.order_date >= CAST('2023-01-01' AS DATE)
   AND
    o.order_date < CAST('2024-01-01' AS DATE)
  )