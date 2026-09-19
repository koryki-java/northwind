-- to_text overload resolution for the numeric families (INTEGER, DECIMAL).
SELECT
  CAST(c.type_smallint AS VARCHAR) AS smallint_text
, CAST(c.type_integer AS VARCHAR) AS integer_text
, CAST(c.type_bigint AS VARCHAR) AS bigint_text
, CAST(c.type_decimal AS VARCHAR) AS decimal_text
, CAST(c.type_double AS VARCHAR) AS double_text
FROM
 check_type c