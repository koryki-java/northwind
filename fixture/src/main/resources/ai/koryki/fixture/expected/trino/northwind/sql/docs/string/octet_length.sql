-- octet_length: length of the company name in bytes.
SELECT
  length(to_utf8(c.company_name)) AS name_bytes
FROM
 customers c