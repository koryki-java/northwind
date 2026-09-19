-- TIMESTAMP - TIMESTAMP -> the exact elapsed span as fixed seconds (canonical koryki notation under
-- StableFormat; HH:MM:SS for a business format). The span never rolls into calendar days, so over
-- 24h stays clock hours (50:00:00, not "2 days 02:00:00"). Subtracting the same instant in different
-- encodings (INSTANT / Unix epoch seconds / Java epoch millis) reconciles to zero. Each side reduces
-- to epoch-seconds per its encoding, so the semantics are uniform across all dialects.
SELECT
  ROUND((CAST(c.ts_diff_intraday AS DATE) - DATE '1970-01-01') * 86400) - ROUND((CAST(c.ts_diff_base AS DATE) - DATE '1970-01-01') * 86400) AS intraday
, ROUND((CAST(c.ts_diff_multiday AS DATE) - DATE '1970-01-01') * 86400) - ROUND((CAST(c.ts_diff_base AS DATE) - DATE '1970-01-01') * 86400) AS multiday
, ROUND((CAST(c.ts_diff_base AS DATE) - DATE '1970-01-01') * 86400) - ROUND((CAST(c.ts_diff_intraday AS DATE) - DATE '1970-01-01') * 86400) AS negative
, ROUND((CAST(c.ts_diff_base AS DATE) - DATE '1970-01-01') * 86400) - ROUND((CAST(c.ts_diff_base AS DATE) - DATE '1970-01-01') * 86400) AS zero
, ROUND((CAST(c.timestamp_zoned AS DATE) - DATE '1970-01-01') * 86400) - c.timestamp_unix_epoche AS instant_minus_unix
, ROUND((CAST(c.timestamp_zoned AS DATE) - DATE '1970-01-01') * 86400) - (c.timestamp_java_epoche / 1000) AS instant_minus_java
, c.timestamp_unix_epoche - (c.timestamp_java_epoche / 1000) AS unix_minus_java
, ROUND((CAST(c.timestamp_timestamp AS DATE) - DATE '1970-01-01') * 86400) - ROUND((CAST(c.timestamp_timestamp - NUMTODSINTERVAL(3, 'HOUR') - NUMTODSINTERVAL(20, 'MINUTE') - NUMTODSINTERVAL(30, 'SECOND') AS DATE) - DATE '1970-01-01') * 86400) AS self_3h20min30s
FROM
 check_temporal c
WHERE
  c.nr = 1