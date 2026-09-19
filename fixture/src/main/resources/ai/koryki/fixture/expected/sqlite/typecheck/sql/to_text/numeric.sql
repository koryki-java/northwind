-- to_text overload resolution for the numeric families (INTEGER, DECIMAL).
SELECT
  CAST(c.type_smallint AS TEXT) AS smallint_text
, CAST(c.type_integer AS TEXT) AS integer_text
, CAST(c.type_bigint AS TEXT) AS bigint_text
, CAST(c.type_decimal AS TEXT) AS decimal_text
, CAST(c.type_double AS TEXT) AS double_text
FROM
 check_type c