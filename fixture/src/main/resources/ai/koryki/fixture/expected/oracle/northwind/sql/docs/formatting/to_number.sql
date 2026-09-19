-- to_number: read a number out of formatted text — leading blanks and a sign belong to the mask.
-- Only PostgreSQL, Oracle and Snowflake offer the function; the other five declare it unsupported.
SELECT
  to_number('1234', '9999') AS plain
, to_number('  42', '9999') AS padded
, to_number('-17', 'S99') AS signed
FROM
 customers c
WHERE
  c.customer_id = 'ALFKI'