-- to_text overload resolution for the numeric families (INTEGER, DECIMAL).
SELECT
  TO_CHAR(c.type_smallint, 'TM9', 'NLS_NUMERIC_CHARACTERS = ''.,''') AS smallint_text
, TO_CHAR(c.type_integer, 'TM9', 'NLS_NUMERIC_CHARACTERS = ''.,''') AS integer_text
, TO_CHAR(c.type_bigint, 'TM9', 'NLS_NUMERIC_CHARACTERS = ''.,''') AS bigint_text
, TO_CHAR(c.type_decimal, 'TM9', 'NLS_NUMERIC_CHARACTERS = ''.,''') AS decimal_text
, TO_CHAR(c.type_double, 'TM9', 'NLS_NUMERIC_CHARACTERS = ''.,''') AS double_text
FROM
 check_type c