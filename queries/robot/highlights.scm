(comment) @comment

(section_header) @keyword
(extra_text) @comment

(setting_statement) @keyword

(variable_definition (variable_name) @variable)

(keyword_definition (name) @function)
(keyword_definition (body (keyword_setting) @keyword))

(test_case_definition (name) @property)

(keyword_invocation (keyword) @function.call)
(ellipses) @punctuation.delimiter

(argument (text_chunk) @string)
(argument (scalar_variable) @variable)
(argument (list_variable) @variable)
(argument (dictionary_variable) @variable)
(argument (inline_python_expression) @string.special)

(ellipses) @punctuation.delimiter

; Control structures
(for_statement
  "FOR" @repeat
  "END" @repeat)
(for_statement (in "IN" @repeat))
(for_statement (in_range "IN RANGE" @repeat))
(for_statement (in_enumerate "IN ENUMERATE" @repeat))
(for_statement (in_zip "IN ZIP" @repeat))

(while_statement
  "WHILE" @repeat
  "END" @repeat)

(break_statement) @repeat
(continue_statement) @repeat

(if_statement
  "IF" @conditional
  "END" @conditional)
(if_statement (elseif_statement "ELSE IF" @conditional))
(if_statement (else_statement "ELSE" @conditional))

(try_statement
  "TRY" @exception
  "END" @exception)
(try_statement (except_statement "EXCEPT" @exception))
(try_statement (else_statement "ELSE" @exception))
(try_statement (finally_statement "FINALLY" @exception))
