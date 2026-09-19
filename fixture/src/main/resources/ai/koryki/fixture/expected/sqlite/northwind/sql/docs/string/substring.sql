-- substring: first three characters of the company name.
SELECT
  substring(c.company_name, 1, 3) AS abbrev
FROM
 customers c