-- to_varchar: render a value as bounded text.
SELECT
  CAST(c.type_integer AS VARCHAR(40)) AS as_text
FROM
 check_type c