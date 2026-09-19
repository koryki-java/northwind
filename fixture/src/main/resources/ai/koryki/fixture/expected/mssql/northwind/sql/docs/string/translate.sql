-- translate: transliterate German umlauts.
SELECT
  translate(c.company_name, N'äöü', 'aou') AS ascii_name
FROM
 customers c