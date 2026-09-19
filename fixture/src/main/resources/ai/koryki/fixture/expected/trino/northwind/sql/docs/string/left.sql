-- left: first two characters of the postal code.
SELECT
  substr(c.postal_code, 1, 2) AS prefix
FROM
 customers c