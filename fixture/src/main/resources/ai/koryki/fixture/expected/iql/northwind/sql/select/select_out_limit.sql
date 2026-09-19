-- find customers, give company_name, no header
SELECT
  c.company_name
FROM
 customers c
FETCH FIRST 5 ROWS ONLY
