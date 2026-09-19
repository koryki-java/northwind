-- btrim/trim take a SET of characters, not a substring — and strip any of them from either end.
-- Measured before this was fixed: oracle, mssql, mariadb and trino silently dropped the second
-- argument and returned the string untouched; the surplus-argument guard in SqlTemplate turned that
-- into a named abort, and oracle and mssql now render the form properly.
-- MariaDB has no set-based trim at all: its TRIM(BOTH x FROM s) removes a substring and would
-- answer 'helloba'. It declares the two-argument form unsupported, so this fixture is skipped
-- there from the catalog — it used to need an ignore= marker whose own comment had to explain
-- that it was not a result divergence.
SELECT
  LTRIM(RTRIM('abhelloba', 'ab'), 'ab') AS b
, LTRIM(RTRIM('abhelloba', 'ab'), 'ab') AS t
, ltrim('abhello', 'ab') AS l
, rtrim('helloba', 'ab') AS r
FROM
 customers c
WHERE
  c.customer_id = 'ALFKI'