-- ascii: code point of the first character.
SELECT
  unicode(c.company_name) AS first_code
FROM
 customers c