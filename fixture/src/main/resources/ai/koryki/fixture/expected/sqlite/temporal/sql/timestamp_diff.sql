-- TIMESTAMP - TIMESTAMP -> the exact elapsed span as fixed seconds (canonical koryki notation under
-- StableFormat; HH:MM:SS for a business format). The span never rolls into calendar days, so over
-- 24h stays clock hours (50:00:00, not "2 days 02:00:00"). Subtracting the same instant in different
-- encodings (INSTANT / Unix epoch seconds / Java epoch millis) reconciles to zero. Each side reduces
-- to epoch-seconds per its encoding, so the semantics are uniform across all dialects.
SELECT
  CAST(strftime('%s', c.ts_diff_intraday) AS INTEGER) - CAST(strftime('%s', c.ts_diff_base) AS INTEGER) AS intraday
, CAST(strftime('%s', c.ts_diff_multiday) AS INTEGER) - CAST(strftime('%s', c.ts_diff_base) AS INTEGER) AS multiday
, CAST(strftime('%s', c.ts_diff_base) AS INTEGER) - CAST(strftime('%s', c.ts_diff_intraday) AS INTEGER) AS negative
, CAST(strftime('%s', c.ts_diff_base) AS INTEGER) - CAST(strftime('%s', c.ts_diff_base) AS INTEGER) AS zero
, CAST(strftime('%s', replace(c.timestamp_zoned, '+00', 'Z')) AS INTEGER) - c.timestamp_unix_epoche AS instant_minus_unix
, CAST(strftime('%s', replace(c.timestamp_zoned, '+00', 'Z')) AS INTEGER) - (c.timestamp_java_epoche / 1000) AS instant_minus_java
, c.timestamp_unix_epoche - (c.timestamp_java_epoche / 1000) AS unix_minus_java
, CAST(strftime('%s', c.timestamp_timestamp) AS INTEGER) - CAST(strftime('%s', datetime(c.timestamp_timestamp, '-3 hours', '-20 minutes', '-30 seconds')) AS INTEGER) AS self_3h20min30s
FROM
 check_temporal c
WHERE
  c.nr = 1