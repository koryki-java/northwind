-- overlay: mask the first two characters of the phone.
SELECT
  SUBSTR(c.phone, 1, 1 - 1) || 'XX' || SUBSTR(c.phone, 1 + 2) AS masked
FROM
 customers c