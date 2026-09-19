-- TIME stored as an ISO text string (TIME_FROM_STRING): arithmetic decodes to seconds, adds, re-wraps.
SELECT
  c.time_from_string AS time_from_string
, TO_NUMBER(SUBSTR(c.time_from_string, 1, 2)) * 3600 + TO_NUMBER(SUBSTR(c.time_from_string, 4, 2)) * 60 + TO_NUMBER(SUBSTR(c.time_from_string, 7, 2)) + 3600 AS time_from_string_plus1h
, TO_NUMBER(SUBSTR(c.time_from_string, 1, 2)) * 3600 + TO_NUMBER(SUBSTR(c.time_from_string, 4, 2)) * 60 + TO_NUMBER(SUBSTR(c.time_from_string, 7, 2)) - 3600 AS time_from_string_minus1h
FROM
 check_temporal c