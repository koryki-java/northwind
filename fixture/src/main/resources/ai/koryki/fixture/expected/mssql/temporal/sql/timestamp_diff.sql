-- TIMESTAMP - TIMESTAMP -> the exact elapsed span as fixed seconds (canonical koryki notation under
-- StableFormat; HH:MM:SS for a business format). The span never rolls into calendar days, so over
-- 24h stays clock hours (50:00:00, not "2 days 02:00:00"). Subtracting the same instant in different
-- encodings (INSTANT / Unix epoch seconds / Java epoch millis) reconciles to zero. Each side reduces
-- to epoch-seconds per its encoding, so the semantics are uniform across all dialects.
SELECT
  DATEDIFF_BIG(SECOND, '1970-01-01', c.ts_diff_intraday) - DATEDIFF_BIG(SECOND, '1970-01-01', c.ts_diff_base) AS intraday
, DATEDIFF_BIG(SECOND, '1970-01-01', c.ts_diff_multiday) - DATEDIFF_BIG(SECOND, '1970-01-01', c.ts_diff_base) AS multiday
, DATEDIFF_BIG(SECOND, '1970-01-01', c.ts_diff_base) - DATEDIFF_BIG(SECOND, '1970-01-01', c.ts_diff_intraday) AS negative
, DATEDIFF_BIG(SECOND, '1970-01-01', c.ts_diff_base) - DATEDIFF_BIG(SECOND, '1970-01-01', c.ts_diff_base) AS zero
, DATEDIFF_BIG(SECOND, '1970-01-01', CAST(SWITCHOFFSET(c.timestamp_zoned, 0) AS DATETIME2)) - c.timestamp_unix_epoche AS instant_minus_unix
, DATEDIFF_BIG(SECOND, '1970-01-01', CAST(SWITCHOFFSET(c.timestamp_zoned, 0) AS DATETIME2)) - (c.timestamp_java_epoche / 1000) AS instant_minus_java
, c.timestamp_unix_epoche - (c.timestamp_java_epoche / 1000) AS unix_minus_java
, DATEDIFF_BIG(SECOND, '1970-01-01', c.timestamp_timestamp) - DATEDIFF_BIG(SECOND, '1970-01-01', DATEADD(SECOND, -30, DATEADD(MINUTE, -20, DATEADD(HOUR, -3, c.timestamp_timestamp)))) AS self_3h20min30s
FROM
 check_temporal c
WHERE
  c.nr = 1