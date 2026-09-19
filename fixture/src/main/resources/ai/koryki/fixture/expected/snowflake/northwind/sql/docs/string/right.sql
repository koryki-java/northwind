-- right: last four characters of the phone number.
SELECT
  right(c.phone, 4) AS last_four
FROM
 customers c