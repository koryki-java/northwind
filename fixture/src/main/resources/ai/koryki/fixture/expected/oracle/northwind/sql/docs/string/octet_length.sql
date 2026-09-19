-- octet_length: length of the company name in bytes.
SELECT
  LENGTHB(c.company_name) AS name_bytes
FROM
 customers c