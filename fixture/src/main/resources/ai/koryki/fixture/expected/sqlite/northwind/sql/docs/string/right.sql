-- right: last four characters of the phone number.
SELECT
  substr(c.phone, CASE WHEN 4 <= 0 THEN length(c.phone) + 1 ELSE max(length(c.phone) - 4 + 1, 1) END) AS last_four
FROM
 customers c