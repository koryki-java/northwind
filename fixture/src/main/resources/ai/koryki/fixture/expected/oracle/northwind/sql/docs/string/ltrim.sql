-- ltrim: strip leading whitespace.
SELECT
  ltrim(c.postal_code) AS left_trimmed
FROM
 customers c