SELECT
  TRIM(c.company_name) AS trimmed
, LEN(TRIM(c.company_name)) AS trimmed_len
FROM
 customers c
WHERE
  c.customer_id = 'ALFKI'