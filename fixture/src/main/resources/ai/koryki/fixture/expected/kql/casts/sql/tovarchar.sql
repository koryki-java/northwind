SELECT
  c.company_name
, CAST(c.postal_code AS VARCHAR(10)) AS postal_short
FROM
 customers c
