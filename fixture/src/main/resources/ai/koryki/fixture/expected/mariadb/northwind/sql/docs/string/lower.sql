-- lower: company name in lower case.
SELECT
  lower(upper(c.company_name)) AS quiet
FROM
 customers c