-- regexp_count: occurrences of 'sales' in the notes.
SELECT
  regexp_count(e.notes, 'sales') AS sales_mentions
FROM
 employees e