
; Zig

; Variables
; --------------
(identifier) @variable

(parameter (identifier) @variable)

; ((identifier) @constant
;  (#vim-match? @constant "^[A-Z][A-Z\\d_]+$'"))

; function definition
(function_signature
  name: (identifier) @function)

(function_declaration
  name: (identifier) @function)

; Function calls
(call_expression
  function: (identifier) @function)

(build_in_call_expr
  function: (identifier) @function.builtin
)

;; other identifiers
(type_identifier) @type
(primitive_type) @type.builtin
(field_identifier) @field

(line_comment) @comment
(doc_comment) @comment

(char_literal) @number
(integer_literal) @number
(float_literal) @number

(boolean_literal) @boolean
(undefined_literal) @constant.builtin
(null_literal) @constant.builtin

; (ERROR) @error

(string_literal) @string
(multiline_string_literal) @string 

(escape_sequence) @constant.builtin

(label_identifier) @label

(call_modifier) @keyword ; async

(binary_operator) @keyword.operator

[
  "align"
  "allowzero"
  ; "and"
  ; "anyframe"
  ; "anytype"
  ;"asm"
  "await"
  "break"
  ; "callconv"
  ; "catch"
  "comptime"
  "const"
  "continue"
  "defer"
  "else"
  "enum"
  "errdefer"
  "error"
  "export"
  "extern"
  "false"
  "for"
  "if"
  "inline"
  ; "noalias"
  ; "nosuspend"
  ; "noinline"
  "null"
  ; "opaque"
  ; "or"
  ; "orelse"
  ; "packed"
  "pub"
  "resume"
  "return"
  ; "linksection"
  "struct"
  "suspend"
  "switch"
  "test"
  ; "threadlocal"
  "true"
  "try"
  ; "undefined"
  "union"
  ;"unreachable"
  "usingnamespace"
  "var"
  "volatile"
  "while"
] @keyword

"fn" @keyword.function

[
  "continue"
  "else"
  "if"
  "switch"
] @conditional

[
  "for"
  "while"
] @repeat

(assignment_modifier) @attribute

[
  ".{"
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

[
  "&"
  "&="
  "*"
  "*="
  ;"*%"
  "*%="
  ;"^"
  "^="
  ":"
  ","
  "."
  ".."
  "..."
  ".*"
  ".?"
  "="
  ;"=="
  "=>"
  "!"
  ;"!="
  ;"<"
  ;"<<"
  "<<="
  ; "<="
  "-"
  "-="
  "-%"
  "-%="
  ;"->"
  ;"%"
  "%="
  "|"
  ;"||"
  "|="
  ;"+"
  ;"++"
  "+="
  ;"+%"
  "+%="
  "?"
  ;">"
  ;">>"
  ">>="
  ;">="
  ;"/"
  "/="
  "~"
] @operator

[
  ";"
  "."
  ","
] @punctuation.delimiter

