-- TIMESTAMP - TIMESTAMP -> the exact elapsed span as fixed seconds (canonical koryki notation under
-- StableFormat; HH:MM:SS for a business format). The span never rolls into calendar days, so over
-- 24h stays clock hours (50:00:00, not "2 days 02:00:00"). Subtracting the same instant in different
-- encodings (INSTANT / Unix epoch seconds / Java epoch millis) reconciles to zero. Each side reduces
-- to epoch-seconds per its encoding, so the semantics are uniform across all dialects.
SELECT
  UNIX_TIMESTAMP(c.ts_diff_intraday) - UNIX_TIMESTAMP(c.ts_diff_base) AS intraday
, UNIX_TIMESTAMP(c.ts_diff_multiday) - UNIX_TIMESTAMP(c.ts_diff_base) AS multiday
, UNIX_TIMESTAMP(c.ts_diff_base) - UNIX_TIMESTAMP(c.ts_diff_intraday) AS negative
, UNIX_TIMESTAMP(c.ts_diff_base) - UNIX_TIMESTAMP(c.ts_diff_base) AS zero
, UNIX_TIMESTAMP(c.timestamp_zoned) - c.timestamp_unix_epoche AS instant_minus_unix
, UNIX_TIMESTAMP(c.timestamp_zoned) - (c.timestamp_java_epoche / 1000) AS instant_minus_java
, c.timestamp_unix_epoche - (c.timestamp_java_epoche / 1000) AS unix_minus_java
, UNIX_TIMESTAMP(c.timestamp_timestamp) - UNIX_TIMESTAMP(c.timestamp_timestamp - INTERVAL '3' HOUR - INTERVAL '20' MINUTE - INTERVAL '30' SECOND) AS self_3h20min30s
FROM
 check_temporal c
WHERE
  c.nr = 1