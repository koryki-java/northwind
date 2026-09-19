-- to_text overload resolution for the temporal families (DATE, TIME, TIMESTAMP).
SELECT
  CAST(c.type_date AS CHAR) AS date_text
, CAST(c.type_time AS CHAR) AS time_text
, CAST(c.type_timestamp AS CHAR) AS timestamp_text
FROM
 check_type c