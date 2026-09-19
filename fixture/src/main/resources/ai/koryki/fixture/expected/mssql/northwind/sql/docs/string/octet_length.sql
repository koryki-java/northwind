-- octet_length: length of the company name in bytes.
SELECT
  DATALENGTH(c.company_name) AS name_bytes
FROM
 customers c