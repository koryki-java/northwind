-- overlay: mask the first two characters of the phone.
SELECT
  substr(c.phone, 1, 1 - 1) || 'XX' || substr(c.phone, 1 + 2) AS masked
FROM
 customers c