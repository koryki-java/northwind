-- count_distinct over several values counts distinct COMBINATIONS. An order line is identified by
-- order and product together, so naming the entity counts lines (2155) while naming one key column
-- counts orders (830) -- both legitimate questions, and this asks the first.
-- Three spellings behind one query: a row constructor on duckdb/postgresql/trino, a comma list on
-- mariadb/snowflake, and a refusal on oracle/mssql/sqlite that names the concat workaround.
SELECT
  COUNT(DISTINCT od.order_id, od.product_id) AS combinations
FROM
 order_details od