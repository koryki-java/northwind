-- substring: first three characters of the company name.
SELECT
  SUBSTR(c.company_name, 1, 3) AS abbrev
FROM
 customers c