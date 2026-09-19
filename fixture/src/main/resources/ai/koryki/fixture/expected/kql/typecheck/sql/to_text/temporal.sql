-- to_text overload resolution for the temporal families (DATE, TIME, TIMESTAMP).
SELECT
  CAST(c.type_date AS TEXT) AS date_text
, CAST(c.type_time AS TEXT) AS time_text
, CAST(c.type_timestamp AS TEXT) AS timestamp_text
FROM
 check_type c