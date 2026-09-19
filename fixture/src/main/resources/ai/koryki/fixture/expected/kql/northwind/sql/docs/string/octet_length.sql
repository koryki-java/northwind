-- octet_length: length of the company name in bytes.
SELECT
  octet_length(encode(c.company_name)) AS name_bytes
FROM
 customers c