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
 "$"
] @punctuation.special

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

(variable_assignment (word) @string)

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

(special_variable_name) @constant

((word) @constant.builtin
 (#vim-match? @constant.builtin "SIG(INT|TERM|QUIT|TIN|TOU|STP|HUP)"))

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

(command_name (word) @function)

((command_name (word) @function.builtin)
 (#match? @function.builtin "^(cd|echo|eval|exit|getopts|pushd|popd|return|set|shift)$"))

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

(expansion
  [ "${" "}" ] @punctuation.bracket)

(variable_name) @variable

((variable_name) @constant
 (#match? @constant "^[A-Z][A-Z_0-9]*$"))

(case_item
  value: (word) @parameter)

(concatenation (word) @parameter)
