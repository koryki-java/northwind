-- find customers, give company_name, no header
SELECT
  c.company_name
, c.customer_id AS id
FROM
 customers c