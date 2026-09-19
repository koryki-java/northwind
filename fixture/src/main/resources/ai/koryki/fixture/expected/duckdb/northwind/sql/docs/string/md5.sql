-- md5: MD5 hash of the company name.
SELECT
  md5(c.company_name) AS hash
FROM
 customers c