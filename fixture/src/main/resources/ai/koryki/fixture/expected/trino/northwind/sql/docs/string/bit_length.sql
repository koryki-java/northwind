-- bit_length: length of the company name in bits.
SELECT
  length(to_utf8(c.company_name)) * 8 AS name_bits
FROM
 customers c