SELECT
  trim(c.company_name) AS trimmed
, LENGTH(trim(c.company_name)) AS trimmed_len
FROM
 customers c
WHERE
  c.customer_id = 'ALFKI'