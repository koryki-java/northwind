-- rpad: right-pad the postal code to width ten with spaces.
SELECT
  rpad(c.postal_code, 10, ' ') AS padded
FROM
 customers c