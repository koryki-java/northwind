-- rtrim: strip trailing whitespace.
SELECT
  rtrim(c.postal_code) AS right_trimmed
FROM
 customers c