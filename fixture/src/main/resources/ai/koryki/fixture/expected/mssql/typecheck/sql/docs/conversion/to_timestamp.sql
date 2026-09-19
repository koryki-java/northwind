-- to_timestamp: extend a DATE to midnight.
SELECT
  CAST(c.type_date AS DATETIME2) AS as_ts
FROM
 check_type c