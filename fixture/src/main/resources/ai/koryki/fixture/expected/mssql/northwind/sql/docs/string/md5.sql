-- md5: MD5 hash of the company name.
SELECT
  LOWER(CONVERT(VARCHAR(32), HASHBYTES('MD5', c.company_name), 2)) AS hash
FROM
 customers c