-- position: position of a dash within the phone.
SELECT
  CHARINDEX('-', c.phone) AS dash_pos
FROM
 customers c