; Include

"#include" @include
(include_path) @string

; Preproc

[
  "#pragma"
] @preproc

(pragma_directive
  [
    "version"
    "not-version"
    "test-version-set"
  ] @preproc)

; Functions/Methods

(function_definition
  name: (function_name) @function)

(function_application
  function: (identifier) @function)

(method_call
  method_name: (identifier) @method.call)

; Parameters

(parameter) @parameter

(function_application
  arguments: [(identifier) (underscore)] @parameter)
(function_application
  arguments: (tensor_expression 
               (identifier) @parameter))
(function_application
  arguments: (parenthesized_expression
               (identifier) @parameter))

(method_call
  arguments: [(identifier) (underscore)] @parameter)
(method_call
  arguments: (tensor_expression 
               (identifier) @parameter))
(method_call
  arguments: (parenthesized_expression
               (identifier) @parameter))

; Constants

(const_var_declarations
  name: (identifier) @constant)
(unit_literal) @constant.builtin

; Variables

(identifier) @variable

; Types

(type_identifier) @type
(primitive_type) @type.builtin
(unit_type) @type.builtin

; Operators

[
  "="
  "+="
  "-="
  "*="
  "/="
  "~/="
  "^/="
  "%="
  "~%="
  "^%="
  "<<="
  ">>="
  "~>>="
  "^>>="
  "&="
  "|="
  "^="
  "=="
  "<"
  ">"
  "<="
  ">="
  "!="
  "<=>"
  "<<"
  ">>"
  "~>>"
  "^>>"
  "-"
  "+"
  "|"
  "^"
  "*"
  "/"
  "%"
  "~/"
  "^/"
  "~%"
  "^%"
  "/%"
  "&"
  "~"
] @operator

; Keywords

[
  "asm"
  "impure"
  "inline"
  "inline_ref"
  "method_id"
  "try"
  "type"
] @keyword

[
  "return"
] @keyword.return

; Conditionals

[
  "if"
  "ifnot"
  "else"
  "elseif"
  "elseifnot"
  "until"
] @conditional

; Exceptions

[
  "catch"
] @exception

; Repeats

[
  "do"
  "forall"
  "repeat"
  "while"
] @repeat

; Qualifiers
[
  "const"
  "global"
  (var)
] @type.qualifier

; Literals

[
  (string)
  (asm_instruction)
] @string

[
  (string_type)
  (underscore)
] @character.special

(number) @number

; Punctuation

["{" "}"] @punctuation.bracket

["(" ")"] @punctuation.bracket

["[" "]"] @punctuation.bracket

[
  ";"
  ","
  "->"
] @punctuation.delimiter

; Comments

(comment) @comment @spell
