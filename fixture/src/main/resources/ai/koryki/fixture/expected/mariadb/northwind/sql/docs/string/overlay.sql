-- overlay: mask the first two characters of the phone.
SELECT
  INSERT(c.phone, 1, 2, 'XX') AS masked
FROM
 customers c