-- starts_with: does the company name start with A?
SELECT
  (LEFT(c.company_name, CHAR_LENGTH('A')) = 'A') AS is_a
FROM
 customers c