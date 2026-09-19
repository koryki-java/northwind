-- to_text: render an integer column as text.
SELECT
  TO_CHAR(c.type_integer, 'TM9', 'NLS_NUMERIC_CHARACTERS = ''.,''') AS integer_text
FROM
 check_type c