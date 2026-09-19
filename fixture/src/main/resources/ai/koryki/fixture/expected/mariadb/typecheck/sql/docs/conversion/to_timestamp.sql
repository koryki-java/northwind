-- to_timestamp: extend a DATE to midnight.
SELECT
  CAST(c.type_date AS DATETIME) AS as_ts
FROM
 check_type c