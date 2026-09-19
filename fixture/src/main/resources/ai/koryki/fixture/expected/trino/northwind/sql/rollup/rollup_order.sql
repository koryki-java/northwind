-- ROLLUP combined with ORDER BY on the same SELECT.
-- Dialect note — MariaDB rejects the combination (server error 1221) and SQLite rejects
-- the ROLLUP itself; both must fail validation rather than the driver.
SELECT
  c.country
, count(o.order_id)
FROM
 customers c
  INNER JOIN orders o ON
   c.customer_id = o.customer_id
GROUP BY ROLLUP (
  c.country)
ORDER BY
  c.country ASC