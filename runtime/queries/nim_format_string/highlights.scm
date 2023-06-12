(string_literal)

(matching_curlies
  opening_curly: (opening_curly) @punctuation.special
  equals: (equals)? @punctuation.special
  closing_curly: (closing_curly) @punctuation.special)

(format_specifiers
  colon: (colon) @punctuation.delimiter
  fill_align: (fill_align)? @keyword.conditional.ternary
  sign: (sign)? @operator
  hash: (hash)? @punctuation.special
  zero: (zero)? @variable.member
  min_width: (min_width)? @number
  precision: (precision)? @number
  type: (type)? @type)

(matching_curlies
  nim_expression: (nim_expression
    escaped_curly: (escaped_curly)+ @string.escape) @none)
