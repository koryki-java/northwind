-- overlay: mask the first two characters of the phone.
SELECT
  overlay(c.phone, 'XX', 1, 2) AS masked
FROM
 customers c