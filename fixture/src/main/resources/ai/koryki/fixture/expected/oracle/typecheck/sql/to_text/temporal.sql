-- to_text overload resolution for the temporal families (DATE, TIME, TIMESTAMP).
SELECT
  TO_CHAR(c.type_date, 'YYYY-MM-DD') AS date_text
, TO_CHAR(c.type_time, 'HH24:MI:SS') AS time_text
, TO_CHAR(c.type_timestamp, 'YYYY-MM-DD HH24:MI:SS') AS timestamp_text
FROM
 check_type c