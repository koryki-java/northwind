-- TIME held under two different encodings, compared column-to-column: time_from_integer is HHMMSS
-- (123050), time_from_string is 'HH:MM:SS' ('12:30:50'). Both convert losslessly to seconds-of-day,
-- so the comparison happens there — the packed integer is unpacked, the text is parsed, and neither
-- representation is privileged. Seconds is also where TIME arithmetic runs, so the two agree.
SELECT
  c.nr AS nr
, c.time_from_integer AS from_integer
, c.time_from_string AS from_string
FROM
 check_temporal c
WHERE
  FLOOR(c.time_from_integer / 10000) * 3600 + MOD(FLOOR(c.time_from_integer / 100), 100) * 60 + MOD(c.time_from_integer, 100) = TIME_TO_SEC(c.time_from_string)