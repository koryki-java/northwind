-- LIKE : customers whose company name starts with 'A'.
SELECT
  c.customer_id
, c.company_name
FROM
 customers c
WHERE
  c.company_name LIKE 'A%'