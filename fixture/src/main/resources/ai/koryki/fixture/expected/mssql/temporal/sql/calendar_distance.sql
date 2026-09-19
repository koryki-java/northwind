-- calendar_distance(start, end): the VARIABLE calendar decomposition (years/months/days + clock),
-- anchored on start — complements the fixed elapsed-seconds ts − ts. SQL emits the two instants as
-- epoch-seconds ("start;end"); the decoder does the calendar decomposition (java.time Period.between),
-- so the result is uniform across all dialects and shown in canonical koryki notation under
-- StableFormat (1y2mo3d4h5min6s). The two parameters may carry DIFFERENT TIMESTAMP encodings —
-- each is reduced to epoch-seconds per its own encoding, so mixed pairs (instant / epoch / naive)
-- work and the same instant in two encodings reconciles to 0s.
SELECT
  CONCAT(DATEDIFF_BIG(SECOND, '1970-01-01', c.ts_diff_base), ';', DATEDIFF_BIG(SECOND, '1970-01-01', c.ts_diff_intraday)) AS intraday
, CONCAT(DATEDIFF_BIG(SECOND, '1970-01-01', c.ts_diff_base), ';', DATEDIFF_BIG(SECOND, '1970-01-01', c.ts_diff_multiday)) AS multiday
, CONCAT(DATEDIFF_BIG(SECOND, '1970-01-01', c.ts_diff_base), ';', DATEDIFF_BIG(SECOND, '1970-01-01', DATEADD(SECOND, 6, DATEADD(MINUTE, 5, DATEADD(HOUR, 4, DATEADD(DAY, 3, DATEADD(MONTH, 14, c.ts_diff_base))))))) AS roundtrip
, CONCAT(DATEDIFF_BIG(SECOND, '1970-01-01', CAST(SWITCHOFFSET(c.timestamp_zoned, 0) AS DATETIME2)), ';', (c.timestamp_java_epoche / 1000)) AS instant_vs_epoch_millis
, CONCAT(c.timestamp_unix_epoche, ';', DATEDIFF_BIG(SECOND, '1970-01-01', c.ts_diff_multiday)) AS epoch_secs_vs_naive
, CONCAT(DATEDIFF_BIG(SECOND, '1970-01-01', c.ts_diff_base), ';', DATEDIFF_BIG(SECOND, '1970-01-01', CAST(SWITCHOFFSET(c.timestamp_zoned, 0) AS DATETIME2))) AS naive_vs_instant_negative
FROM
 check_temporal c
WHERE
  c.nr = 1