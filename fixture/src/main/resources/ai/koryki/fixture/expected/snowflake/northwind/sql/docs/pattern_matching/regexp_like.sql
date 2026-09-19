-- regexp_like: does the company name start with A?
SELECT
  (REGEXP_INSTR(c.company_name, '^A') > 0) AS starts_with_a
FROM
 customers c