-- trim: strip surrounding whitespace.
SELECT
  trim(c.company_name) AS trimmed
FROM
 customers c