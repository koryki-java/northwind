-- regexp_substr: first run of digits in a phone number.
SELECT
  regexp_extract(c.phone, '[0-9]+') AS first_digits
FROM
 customers c