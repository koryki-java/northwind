-- TIME stored as an ISO text string (TIME_FROM_STRING): arithmetic decodes to seconds, adds, re-wraps.
SELECT
  c.time_from_string AS time_from_string
, HOUR(CAST(c.time_from_string AS TIME)) * 3600 + MINUTE(CAST(c.time_from_string AS TIME)) * 60 + SECOND(CAST(c.time_from_string AS TIME)) + 3600 AS time_from_string_plus1h
, HOUR(CAST(c.time_from_string AS TIME)) * 3600 + MINUTE(CAST(c.time_from_string AS TIME)) * 60 + SECOND(CAST(c.time_from_string AS TIME)) - 3600 AS time_from_string_minus1h
FROM
 check_temporal c