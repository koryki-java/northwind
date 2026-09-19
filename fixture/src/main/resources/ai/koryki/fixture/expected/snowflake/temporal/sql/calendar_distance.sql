-- calendar_distance(start, end): the VARIABLE calendar decomposition (years/months/days + clock),
-- anchored on start — complements the fixed elapsed-seconds ts − ts. SQL emits the two instants as
-- epoch-seconds ("start;end"); the decoder does the calendar decomposition (java.time Period.between),
-- so the result is uniform across all dialects and shown in canonical koryki notation under
-- StableFormat (1y2mo3d4h5min6s). The two parameters may carry DIFFERENT TIMESTAMP encodings —
-- each is reduced to epoch-seconds per its own encoding, so mixed pairs (instant / epoch / naive)
-- work and the same instant in two encodings reconciles to 0s.
SELECT
  (CAST(DATE_PART(EPOCH_SECOND, c.ts_diff_base) AS VARCHAR) || ';' || CAST(DATE_PART(EPOCH_SECOND, c.ts_diff_intraday) AS VARCHAR)) AS intraday
, (CAST(DATE_PART(EPOCH_SECOND, c.ts_diff_base) AS VARCHAR) || ';' || CAST(DATE_PART(EPOCH_SECOND, c.ts_diff_multiday) AS VARCHAR)) AS multiday
, (CAST(DATE_PART(EPOCH_SECOND, c.ts_diff_base) AS VARCHAR) || ';' || CAST(DATE_PART(EPOCH_SECOND, c.ts_diff_base + INTERVAL '14 month, 3 day, 4 hour, 5 minute, 6 second') AS VARCHAR)) AS roundtrip
, (CAST(DATE_PART(EPOCH_SECOND, c.timestamp_zoned) AS VARCHAR) || ';' || CAST((c.timestamp_java_epoche / 1000) AS VARCHAR)) AS instant_vs_epoch_millis
, (CAST(c.timestamp_unix_epoche AS VARCHAR) || ';' || CAST(DATE_PART(EPOCH_SECOND, c.ts_diff_multiday) AS VARCHAR)) AS epoch_secs_vs_naive
, (CAST(DATE_PART(EPOCH_SECOND, c.ts_diff_base) AS VARCHAR) || ';' || CAST(DATE_PART(EPOCH_SECOND, c.timestamp_zoned) AS VARCHAR)) AS naive_vs_instant_negative
FROM
 check_temporal c
WHERE
  c.nr = 1