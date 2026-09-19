-- right: last four characters of the phone number.
SELECT
  SUBSTR(c.phone, CASE WHEN 4 <= 0 THEN LENGTH(c.phone) + 1 ELSE GREATEST(LENGTH(c.phone) - 4 + 1, 1) END) AS last_four
FROM
 customers c