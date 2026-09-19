-- find customers, give company_name, no header
SELECT
  c.company_name
FROM
 customers c
ORDER BY
  c.company_name DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY