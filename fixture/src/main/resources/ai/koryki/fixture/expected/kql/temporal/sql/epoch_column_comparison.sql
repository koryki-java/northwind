-- Two columns of one family stored under DIFFERENT encodings, compared with each other:
-- timestamp_unix_epoche is EPOCH:SECONDS, timestamp_java_epoche is EPOCH:MILLIS. Neither side is a
-- literal, so the literal-encoding hooks do not apply — the operands are reconciled onto their
-- lossless common encoding instead. That is millis: seconds -> millis is an exact scale-up, the
-- reverse would truncate. So the SECONDS side is scaled up rather than the MILLIS side truncated.
SELECT
  c.nr AS nr
, c.timestamp_unix_epoche AS unix_epoch
, c.timestamp_java_epoche AS java_epoch
FROM
 check_temporal c
WHERE
  (c.timestamp_unix_epoche) * 1000 = c.timestamp_java_epoche