-- power: freight squared.
SELECT
  POWER(CAST(o.freight AS FLOAT), 2) AS squared
FROM
 orders o