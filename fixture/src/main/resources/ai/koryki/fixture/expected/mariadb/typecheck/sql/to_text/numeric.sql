-- to_text overload resolution for the numeric families (INTEGER, DECIMAL).
SELECT
  CAST(c.type_smallint AS CHAR) AS smallint_text
, CAST(c.type_integer AS CHAR) AS integer_text
, CAST(c.type_bigint AS CHAR) AS bigint_text
, CAST(c.type_decimal AS CHAR) AS decimal_text
, CAST(c.type_double AS CHAR) AS double_text
FROM
 check_type c