-- to_text: render an integer column as text.
SELECT
  CAST(c.type_integer AS VARCHAR(MAX)) AS integer_text
FROM
 check_type c