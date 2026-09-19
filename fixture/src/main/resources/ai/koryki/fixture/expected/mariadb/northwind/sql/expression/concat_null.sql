-- concat skips a blank argument, it does not turn the whole result blank — on every dialect.
-- Measured before this was levelled: MariaDB and Trino returned blank for the whole expression
-- while duckdb, postgresql, oracle, sqlite and SQL Server skipped the blank and returned 'ab'.
-- concat_ws behaved uniformly all along and is here as the control.
SELECT
  concat_ws('', 'a', NULL, 'b') AS joined
, concat_ws('-', 'a', NULL, 'b') AS joined_with_sep
FROM
 customers c
WHERE
  c.customer_id = 'ALFKI'