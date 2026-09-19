-- left: first two characters of the postal code.
SELECT
  left(c.postal_code, 2) AS prefix
FROM
 customers c