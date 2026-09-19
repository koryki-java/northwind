-- lpad: left-pad the postal code to width six with zeros.
SELECT
  lpad(c.postal_code, 6, '0') AS padded
FROM
 customers c