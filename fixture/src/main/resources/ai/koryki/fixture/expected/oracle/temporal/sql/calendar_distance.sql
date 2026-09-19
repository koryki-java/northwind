-- calendar_distance(start, end): the VARIABLE calendar decomposition (years/months/days + clock),
-- anchored on start — complements the fixed elapsed-seconds ts − ts. SQL emits the two instants as
-- epoch-seconds ("start;end"); the decoder does the calendar decomposition (java.time Period.between),
-- so the result is uniform across all dialects and shown in canonical koryki notation under
-- StableFormat (1y2mo3d4h5min6s). The two parameters may carry DIFFERENT TIMESTAMP encodings —
-- each is reduced to epoch-seconds per its own encoding, so mixed pairs (instant / epoch / naive)
-- work and the same instant in two encodings reconciles to 0s.
SELECT
  (TO_CHAR(ROUND((CAST(c.ts_diff_base AS DATE) - DATE '1970-01-01') * 86400)) || ';' || TO_CHAR(ROUND((CAST(c.ts_diff_intraday AS DATE) - DATE '1970-01-01') * 86400))) AS intraday
, (TO_CHAR(ROUND((CAST(c.ts_diff_base AS DATE) - DATE '1970-01-01') * 86400)) || ';' || TO_CHAR(ROUND((CAST(c.ts_diff_multiday AS DATE) - DATE '1970-01-01') * 86400))) AS multiday
, (TO_CHAR(ROUND((CAST(c.ts_diff_base AS DATE) - DATE '1970-01-01') * 86400)) || ';' || TO_CHAR(ROUND((CAST((ADD_MONTHS(c.ts_diff_base, 14) - GREATEST(EXTRACT(DAY FROM ADD_MONTHS(c.ts_diff_base, 14)) - EXTRACT(DAY FROM c.ts_diff_base), 0)) + NUMTODSINTERVAL(3, 'DAY') + NUMTODSINTERVAL(4, 'HOUR') + NUMTODSINTERVAL(5, 'MINUTE') + NUMTODSINTERVAL(6, 'SECOND') AS DATE) - DATE '1970-01-01') * 86400))) AS roundtrip
, (TO_CHAR(ROUND((CAST(c.timestamp_zoned AS DATE) - DATE '1970-01-01') * 86400)) || ';' || TO_CHAR((c.timestamp_java_epoche / 1000))) AS instant_vs_epoch_millis
, (TO_CHAR(c.timestamp_unix_epoche) || ';' || TO_CHAR(ROUND((CAST(c.ts_diff_multiday AS DATE) - DATE '1970-01-01') * 86400))) AS epoch_secs_vs_naive
, (TO_CHAR(ROUND((CAST(c.ts_diff_base AS DATE) - DATE '1970-01-01') * 86400)) || ';' || TO_CHAR(ROUND((CAST(c.timestamp_zoned AS DATE) - DATE '1970-01-01') * 86400))) AS naive_vs_instant_negative
FROM
 check_temporal c
WHERE
  c.nr = 1