-- to_text: render an integer column as text.
SELECT
  CAST(c.type_integer AS CHAR) AS integer_text
FROM
 check_type c