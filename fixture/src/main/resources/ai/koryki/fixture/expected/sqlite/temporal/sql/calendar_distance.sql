-- calendar_distance(start, end): the VARIABLE calendar decomposition (years/months/days + clock),
-- anchored on start — complements the fixed elapsed-seconds ts − ts. SQL emits the two instants as
-- epoch-seconds ("start;end"); the decoder does the calendar decomposition (java.time Period.between),
-- so the result is uniform across all dialects and shown in canonical koryki notation under
-- StableFormat (1y2mo3d4h5min6s). The two parameters may carry DIFFERENT TIMESTAMP encodings —
-- each is reduced to epoch-seconds per its own encoding, so mixed pairs (instant / epoch / naive)
-- work and the same instant in two encodings reconciles to 0s.
SELECT
  (CAST(CAST(strftime('%s', c.ts_diff_base) AS INTEGER) AS VARCHAR) || ';' || CAST(CAST(strftime('%s', c.ts_diff_intraday) AS INTEGER) AS VARCHAR)) AS intraday
, (CAST(CAST(strftime('%s', c.ts_diff_base) AS INTEGER) AS VARCHAR) || ';' || CAST(CAST(strftime('%s', c.ts_diff_multiday) AS INTEGER) AS VARCHAR)) AS multiday
, (CAST(CAST(strftime('%s', c.ts_diff_base) AS INTEGER) AS VARCHAR) || ';' || CAST(CAST(strftime('%s', datetime(min(datetime(c.ts_diff_base, '+14 months'), datetime(c.ts_diff_base, 'start of month', '+15 months', '-1 day')), '+3 days', '+4 hours', '+5 minutes', '+6 seconds')) AS INTEGER) AS VARCHAR)) AS roundtrip
, (CAST(CAST(strftime('%s', replace(c.timestamp_zoned, '+00', 'Z')) AS INTEGER) AS VARCHAR) || ';' || CAST((c.timestamp_java_epoche / 1000) AS VARCHAR)) AS instant_vs_epoch_millis
, (CAST(c.timestamp_unix_epoche AS VARCHAR) || ';' || CAST(CAST(strftime('%s', c.ts_diff_multiday) AS INTEGER) AS VARCHAR)) AS epoch_secs_vs_naive
, (CAST(CAST(strftime('%s', c.ts_diff_base) AS INTEGER) AS VARCHAR) || ';' || CAST(CAST(strftime('%s', replace(c.timestamp_zoned, '+00', 'Z')) AS INTEGER) AS VARCHAR)) AS naive_vs_instant_negative
FROM
 check_temporal c
WHERE
  c.nr = 1