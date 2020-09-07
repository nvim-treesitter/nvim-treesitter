[
 "("
 ")"
 "{"
 "}"
 "["
 "]"
 ] @punctuation.bracket

[
 ";"
 ";;"
 (heredoc_start)
 ] @punctuation.delimiter

[
 ">"
 "<"
 "&"
 "&&"
 "|"
 "||"
 "="
 "=="
 "!="
 ] @operator

[
 (string)
 (raw_string)
 (heredoc_body)
] @string

[
 "if"
 "then"
 "else"
 "elif"
 "fi"
 "case"
 "in"
 "esac"
 ] @conditional

[
 "for"
 "do"
 "done"
 "while"
 ] @repeat

[
 "declare"
 "export"
 "local"
 "readonly"
 "unset"
 ] @keyword

[
 (special_variable_name)
 ("$" (special_variable_name))
 ] @constant

((word) @constant
  (#vim-match? @constant "SIG(INT|TERM|QUIT|TIN|TOU|STP|HUP)"))

((word) @boolean
  (#vim-match? @boolean "true|false"))

((word) @number
  (#vim-match? @number "^\d*$"))

(comment) @comment
(test_operator) @string

(command_substitution
  [ "$(" ")" ] @punctuation.bracket)


(function_definition
  name: (word) @function)

(command_name (word)) @function

(command
  argument: [
             (word) @parameter
             ((word) @number
              (#vim-match? @number "^\d*$"))
             (concatenation (word) @parameter)
             ])

(file_redirect
  descriptor: (file_descriptor) @operator
  destination: (word) @parameter)


("$" (variable_name)) @variable

(expansion
  [ "${" "}" ] @punctuation.bracket)

(variable_name) @variable

(case_item
  value: (word) @parameter)

(concatenation (word) @parameter)

