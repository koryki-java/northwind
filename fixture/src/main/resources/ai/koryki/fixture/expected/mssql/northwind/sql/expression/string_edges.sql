-- The edges of right() and substring(), pinned because the shims used to get them wrong.
-- Measured before: right(s, 0) returned the WHOLE string on Oracle and SQLite, because their
-- shim was substr(s, -n) and -0 is 0; right(s, 20) returned '' on Oracle and Trino; and SQL
-- Server rejected the two-argument substring outright, its SUBSTRING requiring three.
SELECT
  right('alphabet', 0) AS none
, right('alphabet', 3) AS last_three
, right('alphabet', 20) AS longer_than_input
, SUBSTRING('alphabet', 2, LEN('alphabet')) AS from_second
FROM
 customers c
WHERE
  c.customer_id = 'ALFKI'