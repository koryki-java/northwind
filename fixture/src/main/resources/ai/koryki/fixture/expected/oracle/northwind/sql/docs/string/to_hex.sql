-- to_hex: hexadecimal of a number.
SELECT
  TO_CHAR(255, 'FMXXXXXXXXXXXXXXXX') AS hex_ff
FROM
 customers c