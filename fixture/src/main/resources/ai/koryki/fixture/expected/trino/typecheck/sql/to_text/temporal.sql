-- to_text overload resolution for the temporal families (DATE, TIME, TIMESTAMP).
SELECT
  CAST(c.type_date AS VARCHAR) AS date_text
, CAST(c.type_time AS VARCHAR) AS time_text
, CAST(c.type_timestamp AS VARCHAR) AS timestamp_text
FROM
 check_type c