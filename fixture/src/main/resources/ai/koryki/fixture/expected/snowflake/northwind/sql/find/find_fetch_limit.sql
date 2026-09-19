-- find customers, give company_name, no header
SELECT
  c.company_name
FROM
 customers c
ORDER BY
  c.company_name DESC
FETCH FIRST 5 ROWS ONLY