-- find customers, give company_name, filter by company_name
SELECT
  c.company_name
FROM
 customers c
WHERE
  c.company_name LIKE 'abc%'
 AND
  (
    c.customer_id < 10
   OR
    c.city = 'Berlin'
  )
