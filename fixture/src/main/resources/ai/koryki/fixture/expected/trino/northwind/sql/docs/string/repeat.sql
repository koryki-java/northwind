-- repeat: a ten-character rule.
SELECT
  array_join(repeat('-', 10), '') AS ruler
FROM
 customers c