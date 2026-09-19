-- to_text overload resolution for the remaining families (BOOLEAN, TEXT, BLOB, INTERVAL, UUID, JSON).
SELECT
  CAST(c.type_boolean AS VARCHAR) AS boolean_text
FROM
 check_type c