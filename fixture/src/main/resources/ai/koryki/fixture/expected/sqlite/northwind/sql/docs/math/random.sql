-- random: a random value in [0, 1).
SELECT
  (random() / 18446744073709551616.0 + 0.5) AS r
FROM
 orders o