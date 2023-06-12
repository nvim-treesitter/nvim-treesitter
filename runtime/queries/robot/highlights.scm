[
  (comment)
  (extra_text)
] @comment @spell

[
  (section_header)
  (setting_statement)
  (keyword_setting)
  (test_case_setting)
] @keyword

(variable_definition
  (variable_name) @variable)

(keyword_definition
  (name) @function)

(test_case_definition
  (name) @function)

(keyword_invocation
  (keyword) @function.call)

(ellipses) @punctuation.delimiter

(text_chunk) @string

(inline_python_expression) @string.special

[
  (scalar_variable)
  (list_variable)
  (dictionary_variable)
] @variable

; Control structures
[
  "FOR"
  "IN"
  "IN RANGE"
  "IN ENUMERATE"
  "IN ZIP"
  (break_statement)
  (continue_statement)
] @keyword.repeat

(for_statement
  "END" @keyword.repeat)

"WHILE" @keyword.repeat

(while_statement
  "END" @keyword.repeat)

[
  "IF"
  "ELSE IF"
] @keyword.conditional

(if_statement
  "END" @keyword.conditional)

(if_statement
  (else_statement
    "ELSE" @keyword.conditional))

[
  "TRY"
  "EXCEPT"
  "FINALLY"
] @keyword.exception

(try_statement
  "END" @keyword.exception)

(try_statement
  (else_statement
    "ELSE" @keyword.exception))
