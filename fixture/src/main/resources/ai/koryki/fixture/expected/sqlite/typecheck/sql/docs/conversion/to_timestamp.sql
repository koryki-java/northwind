-- to_timestamp: extend a DATE to midnight.
SELECT
  datetime(c.type_date) AS as_ts
FROM
 check_type c