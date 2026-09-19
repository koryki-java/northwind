-- starts_with: does the company name start with A?
SELECT
  (substr(c.company_name, 1, length('A')) = 'A') AS is_a
FROM
 customers c