-- parse_date/parse_timestamp with the canonical KQL format mask.
-- SQLite has no strptime and T-SQL's PARSE/CONVERT take a culture or style code rather than a
-- mask, so both declare these unsupported. Before the catalog knew the functions at all, they
-- were merely *unknown* on those two — a warning, and the KQL name passed through verbatim, so
-- their goldens asserted `parse_date('2024-03-15', 'YYYY-MM-DD')` as if it were valid SQL.
SELECT
  strptime('2024-03-15', '%Y-%m-%d')::DATE AS pd
, strptime('2024-03-15 13:45:00', '%Y-%m-%d %H:%M:%S') AS pts
FROM
 customers c
WHERE
  c.customer_id = 'ALFKI'