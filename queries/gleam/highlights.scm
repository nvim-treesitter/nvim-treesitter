; Keywords
[
  "as"
  "const"
  "external"
  "let"
  "opaque"
  "pub"
  "todo"
  "try"
] @keyword

; Function Keywords
[
  "fn"
  "type"
] @keyword.function

; Imports
[
  "import"
] @include

; Conditionals
[
  "case"
  "if"
] @conditional

; Exceptions
[
  "assert"
] @exception

; Punctuation
[
  "("
  ")"
  "<<"
  ">>"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

[
  ","
  "."
] @punctuation.delimiter

[
  "#"
] @punctuation.special

; Operators
[
  "%"
  "&&"
  "*"
  "*."
  "+"
  "+."
  "-"
  "-."
  "->"
  ".."
  "/"
  "/."
  ":"
  "<"
  "<."
  "<="
  "<=."
  "="
  "=="
  ">"
  ">."
  ">="
  ">=."
  "|>"
  "||"
] @operator

; Comments
[
  (module_comment)
  (statement_comment) 
  (comment) 
] @comment

; Unused Identifiers
[
  (discard)
  (hole)
] @comment

; Modules & Imports
(module ("/" @namespace)?) @namespace
(remote_type_identifier module: (identifier) @namespace)
(import alias: ((identifier) @namespace)?)


; Identifiers
(identifier) @variable

; Strings
(string) @string

; TODO Escape Sequences

; TODO: Bit Strings

; Numbers
[
  (integer) 
  (float) 
] @number

; Function Parameter Labels
(function_call arguments: (arguments (argument label: (label) @symbol ":" @symbol)))
(function_parameter label: (label)? @symbol name: (identifier) @parameter (":" @parameter)?)

; Records
(record arguments: (arguments (argument label: (label) @property ":" @property)?))
(record_pattern_argument  label: (label) @property ":" @property)
(record_update_argument label: (label) @property ":" @property)

; Type Constructors
(type_constructor_argument label: (label) @property ":" @property)

; Types
((type_identifier) @type (#not-any-of? @type "True" "False"))

; Booleans
((type_identifier) @boolean (#any-of? @boolean "True" "False"))

; Type Variables
(type_var) @type

; Tuples
(tuple_access index: (integer) @operator)

; Functions
(public_function name: (identifier) @function)

(function name: (identifier) @function)

(function_call function: (identifier) @function)

(function_call function: (field_access record: (identifier) @namespace field: (label) @function))

; Unqualified Imports
(unqualified_import name: (identifier) @function)

; External Functions
(public_external_function name: (identifier) @function)
(external_function_body (string) @namespace . (string) @function)

; Pipe Operator
(binary_expression operator: "|>" right: (identifier) @function)

; Parser Errors
(ERROR) @error

; TODO does nvim-treesitter support #is-not? local matches for highlights?
; see https://github.com/tree-sitter/tree-sitter/pull/448 for documentation
