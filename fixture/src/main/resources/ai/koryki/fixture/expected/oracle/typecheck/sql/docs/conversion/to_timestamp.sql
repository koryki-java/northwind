-- to_timestamp: extend a DATE to midnight.
SELECT
  CAST(c.type_date AS TIMESTAMP) AS as_ts
FROM
 check_type c