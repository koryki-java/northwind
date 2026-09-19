-- rpad: right-pad the postal code to width ten with spaces.
SELECT
  LEFT(CAST(c.postal_code AS VARCHAR(MAX)) + REPLICATE(' ', 10), 10) AS padded
FROM
 customers c