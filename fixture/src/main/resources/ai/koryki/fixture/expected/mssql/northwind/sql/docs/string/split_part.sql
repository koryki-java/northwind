-- split_part: first dash-separated field of the phone.
SELECT
  (SELECT value FROM STRING_SPLIT(c.phone, '-', 1) WHERE ordinal = 1) AS first_field
FROM
 customers c