-- A backslash in a string literal reaches the database as a backslash — on every dialect.
-- MariaDB reads backslashes inside literals as escape characters, unlike the SQL standard and
-- unlike every other dialect here, so '\d+' arrived as 'd+' and matched nothing. Measured: this
-- query returned blank on MariaDB and 030 everywhere else. The POSIX class is the control — it
-- needs no backslash and agreed all along.
SELECT
  regexp_substr(c.phone, '\\d+') AS digits
, regexp_substr(c.phone, '[[:digit:]]+') AS posix
FROM
 customers c
WHERE
  c.customer_id = 'ALFKI'