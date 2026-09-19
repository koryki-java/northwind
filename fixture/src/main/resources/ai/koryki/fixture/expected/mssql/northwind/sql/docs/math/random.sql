-- random: a random value in [0, 1).
SELECT
  RAND(CHECKSUM(NEWID())) AS r
FROM
 orders o