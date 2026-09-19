-- starts_with: does the company name start with A?
SELECT
  (SUBSTR(c.company_name, 1, LENGTH('A')) = 'A') AS is_a
FROM
 customers c