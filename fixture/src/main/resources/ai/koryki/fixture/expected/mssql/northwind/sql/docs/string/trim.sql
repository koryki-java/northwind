-- trim: strip surrounding whitespace.
SELECT
  TRIM(c.company_name) AS trimmed
FROM
 customers c