-- regexp_like: does the company name start with A?
SELECT
  (c.company_name REGEXP '^A') AS starts_with_a
FROM
 customers c