-- TIME stored as an HHMMSS integer (TIME_FROM_INTEGER): arithmetic decodes to seconds, adds, re-wraps.
SELECT
  c.time_from_integer AS time_from_integer
, (c.time_from_integer / 10000) * 3600 + ((c.time_from_integer / 100) % 100) * 60 + (c.time_from_integer % 100) + 3600 AS time_from_integer_plus1h
, (c.time_from_integer / 10000) * 3600 + ((c.time_from_integer / 100) % 100) * 60 + (c.time_from_integer % 100) - 3600 AS time_from_integer_minus1h
FROM
 check_temporal c