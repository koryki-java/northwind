-- starts_with: does the company name start with A?
SELECT
  starts_with(c.company_name, 'A') AS is_a
FROM
 customers c