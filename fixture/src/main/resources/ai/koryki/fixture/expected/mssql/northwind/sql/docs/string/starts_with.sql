-- starts_with: does the company name start with A?
SELECT
  CAST(CASE WHEN (LEFT(c.company_name, LEN('A')) = 'A') THEN 1 ELSE 0 END AS BIT) AS is_a
FROM
 customers c