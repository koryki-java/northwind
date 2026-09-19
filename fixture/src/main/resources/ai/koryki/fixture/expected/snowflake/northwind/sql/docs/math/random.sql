-- random: a random value in [0, 1).
SELECT
  UNIFORM(0::float, 1::float, RANDOM()) AS r
FROM
 orders o