-- bit_length: length of the company name in bits.
SELECT
  bit_length(c.company_name) AS name_bits
FROM
 customers c