-- ascii: code point of the first character.
SELECT
  codepoint(cast(substr(c.company_name, 1, 1) as varchar(1))) AS first_code
FROM
 customers c