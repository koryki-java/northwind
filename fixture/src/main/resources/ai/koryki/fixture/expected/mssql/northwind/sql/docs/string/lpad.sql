-- lpad: left-pad the postal code to width six with zeros.
SELECT
  CASE WHEN LEN(c.postal_code) >= 6 THEN LEFT(c.postal_code, 6) ELSE RIGHT(REPLICATE('0', 6) + CAST(c.postal_code AS VARCHAR(MAX)), 6) END AS padded
FROM
 customers c