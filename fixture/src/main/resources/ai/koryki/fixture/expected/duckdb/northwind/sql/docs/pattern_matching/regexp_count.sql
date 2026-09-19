-- regexp_count: occurrences of 'sales' in the notes.
SELECT
  len(regexp_extract_all(e.notes, 'sales')) AS sales_mentions
FROM
 employees e