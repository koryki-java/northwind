-- starts_with: does the company name start with A?
SELECT
  STARTSWITH(c.company_name, 'A') AS is_a
FROM
 customers c