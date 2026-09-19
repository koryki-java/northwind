-- repeat: a ten-character rule.
SELECT
  RPAD('-', 10 * LENGTH('-'), '-') AS ruler
FROM
 customers c