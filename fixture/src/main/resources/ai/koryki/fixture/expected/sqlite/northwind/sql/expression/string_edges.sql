-- The edges of right() and substring(), pinned because the shims used to get them wrong.
-- Measured before: right(s, 0) returned the WHOLE string on Oracle and SQLite, because their
-- shim was substr(s, -n) and -0 is 0; right(s, 20) returned '' on Oracle and Trino; and SQL
-- Server rejected the two-argument substring outright, its SUBSTRING requiring three.
SELECT
  substr('alphabet', CASE WHEN 0 <= 0 THEN length('alphabet') + 1 ELSE max(length('alphabet') - 0 + 1, 1) END) AS none
, substr('alphabet', CASE WHEN 3 <= 0 THEN length('alphabet') + 1 ELSE max(length('alphabet') - 3 + 1, 1) END) AS last_three
, substr('alphabet', CASE WHEN 20 <= 0 THEN length('alphabet') + 1 ELSE max(length('alphabet') - 20 + 1, 1) END) AS longer_than_input
, substring('alphabet', 2) AS from_second
FROM
 customers c
WHERE
  c.customer_id = 'ALFKI'