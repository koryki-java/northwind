-- to_text overload resolution for the numeric families (INTEGER, DECIMAL).
SELECT
  CAST(c.type_smallint AS VARCHAR(MAX)) AS smallint_text
, CAST(c.type_integer AS VARCHAR(MAX)) AS integer_text
, CAST(c.type_bigint AS VARCHAR(MAX)) AS bigint_text
, CAST(c.type_decimal AS VARCHAR(MAX)) AS decimal_text
, CAST(c.type_double AS VARCHAR(MAX)) AS double_text
FROM
 check_type c