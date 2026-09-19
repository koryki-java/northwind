-- replace: remove dashes from a phone number.
SELECT
  replace(c.phone, '-', '') AS no_dashes
FROM
 customers c