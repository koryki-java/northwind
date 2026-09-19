SELECT
  upper(c.company_name) AS name_upper
, lower(c.company_name) AS name_lower
FROM
 customers c
WHERE
  c.customer_id = 'ALFKI'