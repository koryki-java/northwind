-- TIME stored as an ISO text string (TIME_FROM_STRING): arithmetic decodes to seconds, adds, re-wraps.
SELECT
  c.time_from_string AS time_from_string
, (CAST(substr(c.time_from_string, 1, 2) AS INTEGER) * 3600 + CAST(substr(c.time_from_string, 4, 2) AS INTEGER) * 60 + CAST(substr(c.time_from_string, 7, 2) AS INTEGER)) + 3600 AS time_from_string_plus1h
, (CAST(substr(c.time_from_string, 1, 2) AS INTEGER) * 3600 + CAST(substr(c.time_from_string, 4, 2) AS INTEGER) * 60 + CAST(substr(c.time_from_string, 7, 2) AS INTEGER)) - 3600 AS time_from_string_minus1h
FROM
 check_temporal c