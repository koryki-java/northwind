-- to_hex: hexadecimal of a number.
SELECT
  upper(to_base(255, 16)) AS hex_ff
FROM
 customers c