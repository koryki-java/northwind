-- Two INTERVAL columns counted in different units: interval_seconds is INTERVAL:SECONDS,
-- interval_millis is INTERVAL:MILLIS. Both are clock-class units with a fixed length, so seconds
-- scales up to millis exactly and the comparison happens there. Only units of the SAME class scale
-- this way — DAYS to HOURS is an exact x24 arithmetically but a calendar day is not always 24 hours.
SELECT
  c.nr AS nr
, c.interval_seconds AS seconds
, c.interval_millis AS millis
FROM
 check_temporal c
WHERE
  (c.interval_seconds) * 1000 = c.interval_millis