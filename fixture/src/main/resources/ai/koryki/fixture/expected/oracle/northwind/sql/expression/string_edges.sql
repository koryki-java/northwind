-- The edges of right() and substring(), pinned because the shims used to get them wrong.
-- Measured before: right(s, 0) returned the WHOLE string on Oracle and SQLite, because their
-- shim was substr(s, -n) and -0 is 0; right(s, 20) returned '' on Oracle and Trino; and SQL
-- Server rejected the two-argument substring outright, its SUBSTRING requiring three.
SELECT
  SUBSTR('alphabet', CASE WHEN 0 <= 0 THEN LENGTH('alphabet') + 1 ELSE GREATEST(LENGTH('alphabet') - 0 + 1, 1) END) AS none
, SUBSTR('alphabet', CASE WHEN 3 <= 0 THEN LENGTH('alphabet') + 1 ELSE GREATEST(LENGTH('alphabet') - 3 + 1, 1) END) AS last_three
, SUBSTR('alphabet', CASE WHEN 20 <= 0 THEN LENGTH('alphabet') + 1 ELSE GREATEST(LENGTH('alphabet') - 20 + 1, 1) END) AS longer_than_input
, SUBSTR('alphabet', 2) AS from_second
FROM
 customers c
WHERE
  c.customer_id = 'ALFKI'