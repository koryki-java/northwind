-- TIME stored as an ISO text string (TIME_FROM_STRING): arithmetic decodes to seconds, adds, re-wraps.
SELECT
  c.time_from_string AS time_from_string
, TIME_TO_SEC(c.time_from_string) + 3600 AS time_from_string_plus1h
, TIME_TO_SEC(c.time_from_string) - 3600 AS time_from_string_minus1h
FROM
 check_temporal c