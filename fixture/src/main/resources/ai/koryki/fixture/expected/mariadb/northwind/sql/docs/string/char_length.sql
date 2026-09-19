-- char_length: length of the company name in characters.
SELECT
  CHAR_LENGTH(c.company_name) AS name_len
FROM
 customers c