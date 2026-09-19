-- regexp_like: does the company name start with A?
SELECT
  regexp_matches(c.company_name, '^A') AS starts_with_a
FROM
 customers c