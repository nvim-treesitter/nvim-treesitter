;; Assume all-caps names are constants

; (identifier) @variable

(parameter (identifier) @variable)

; ((identifier) @constant
;  (#vim-match? @constant "^[A-Z][A-Z\\d_]+$'"))

; function definition
(function_signature
  (identifier) @function
)

(function_declaration (identifier) @function)

; Function calls
(call_expression
  function: (identifier) @function)

(build_in_call_expr
  function: (identifier) @attribute)

;; other identifiers
(type_identifier) @type
(primitive_type) @type.builtin
(field_identifier) @property

(line_comment) @comment
(doc_comment) @comment

(char_literal) @number
(integer_literal) @number
(float_literal) @number

(boolean_literal) @constant.builtin
(undefined_literal) @constant.builtin
(null_literal) @constant.builtin

(string_literal) @string
(multiline_string_literal) @string

(escape_sequence) @constant.builtin



[
  "align"
  "allowzero"
  ; "and"
  ; "anyframe"
  ; "anytype"
  ;"asm"
  ; "async"
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
  ; "fn"
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
  ;"<="
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
  "c\""
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

