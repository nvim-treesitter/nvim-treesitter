[ 
  "const"
  "default"
  "enum"
  "extern"
  "inline"
  "return"
  "sizeof"
  "static"
  "struct"
  "typedef"
  "union"
  "volatile"
] @keyword

[ 
  "while"
  "for"
  "do"
  "continue"
  "break"
] @repeat

[
 "if"
 "else"
 "case"
 "switch" 
] @conditional

(conditional_expression [ "?" ":" ] @conditional)

"#define" @constant.macro
[
  "#if"
  "#ifdef"
  "#ifndef"
  "#else"
  "#elif"
  "#endif"
  "#include"
  (preproc_directive)
] @keyword

[
  "--"
  "-"
  "->"
  "!="
  "*"
  "/"
  "&"
  "&&"
  "+"
  "++"
  "<"
  "<="
  "=="
  "="
  "~"
  ">"
  ">="
  "!"
  "||"

  "-="
  "+="
  "*="
  "/="
  "|="
  "&="
] @operator

[ "." ";" ":" "," ] @punctuation.delimiter

[ "(" ")" "[" "]" "{" "}"] @punctuation.bracket

(string_literal) @string
(system_lib_string) @string

(null) @constant.builtin
(number_literal) @number
(char_literal) @number

(call_expression
  function: (identifier) @function)
(call_expression
  function: (field_expression
    field: (field_identifier) @function))
(function_declarator
  declarator: (identifier) @function)
(preproc_function_def
  name: (identifier) @function.macro)
(preproc_arg)  @function.macro
; TODO (preproc_arg)  @embedded

(field_identifier) @property
(statement_identifier) @label
(type_identifier) @type
(primitive_type) @type
(sized_type_specifier) @type

((identifier) @type
 (#match? @type "^[A-Z]"))

((identifier) @constant
 (#match? @constant "^[A-Z][A-Z0-9_]+$"))

(comment) @comment

;; Parameters
(parameter_list
  (parameter_declaration) @parameter)

(preproc_params
  (identifier)) @parameter

(ERROR) @error
