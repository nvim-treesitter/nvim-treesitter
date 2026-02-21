; Comments
[
  (line_comment)
  (block_comment)
] @comment @spell

; String and numeric literals
(string_literal) @string

(escape_sequence) @string.escape

(integer_literal) @number

(boolean_literal) @boolean

; Variables
(identifier) @variable

(args_keyword) @variable.builtin

(argn_identifier) @variable.builtin

(retval_identifier) @variable.builtin

(scratch_variable) @variable

(map_variable) @variable

(script_parameter) @variable.parameter

; Macro
(macro_definition
  (identifier) @function.macro)

; Probes
; fentry/fexit, kprobe/kretprobe, rawtracepoint
(probe
  provider: (_) @type.builtin
  module: (wildcard_identifier) @module
  function: (wildcard_identifier) @property)

(probe
  provider: (_) @type.builtin
  function: (wildcard_identifier) @property)

; uprobe/uretprobe
(probe
  provider: (uprobe_uretprobe_provider) @type.builtin
  binary: (file_identifier) @string.special.path
  function: (identifier) @property)

; tracepoint
(probe
  provider: (_) @type.builtin
  subsys: (wildcard_identifier) @module
  event: (wildcard_identifier) @property)

; software/hardware
(probe
  provider: (_) @type.builtin
  event: (identifier_with_dash) @property
  count: (integer_literal) @number)

(probe
  provider: (_) @type.builtin
  event: (identifier_with_dash) @property)

; bench/test
(probe
  provider: (bench_test_provider) @type.builtin
  function: (identifier) @property)

; profile/interval
(probe
  provider: (profile_interval_provider) @type.builtin
  unit: (time_unit) @string.special
  count: (integer_literal) @property)

(probe
  provider: (profile_interval_provider) @type.builtin
  count: (integer_literal) @number)

; iter
(probe
  provider: (iter_provider) @type.builtin
  object: (identifier) @module
  pin: (file_identifier) @property)

(probe
  provider: (iter_provider) @type.builtin
  object: (identifier) @module)

; ustd
(probe
  provider: (ustd_provider) @type.builtin
  binary: (file_identifier) @string.special.path
  namespace: (identifier) @variable
  function: (identifier) @property)

(probe
  provider: (ustd_provider) @type.builtin
  binary: (file_identifier) @string.special.path
  function: (identifier) @property)

; watchpoint/asyncwatchpoint
(probe
  provider: (watchpoint_provider) @type.builtin
  address: (integer_literal) @number
  length: (integer_literal) @number
  mode: (watchpoint_mode) @property)

; Types
(type_specifier) @type

(integer_type) @type.builtin

[
  "BEGIN"
  "begin"
  "END"
  "end"
] @type.builtin

; Keywords
(hashbang) @keyword.directive

(return_statement) @keyword.return

[
  "config"
  "let"
  "macro"
  "offsetof"
  "sizeof"
] @keyword

[
  "if"
  "else"
] @keyword.conditional

[
  "for"
  "unroll"
  "while"
  (break_statement)
  (continue_statement)
] @keyword.repeat

"import" @keyword.import

(field_expression
  field: (identifier) @property)

(call_expression
  function: (identifier) @function.call)

; Punctuations
[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

[
  ","
  ";"
  ":"
  "."
] @punctuation.delimiter

; Operators
[
  ; Field access
  "->"
  ; Range
  ".."
  ; Assignment
  "="
  "<<="
  ">>="
  "+="
  "-="
  "*="
  "/="
  "%="
  "&="
  "|="
  "^="
  ; Update
  "--"
  "++"
  ; Arithmetic
  "%"
  "+"
  "-"
  "*"
  "/"
  ; Relational
  "<="
  "<"
  ">="
  ">"
  "=="
  "!="
  ; Bitwise
  "&"
  "^"
  "|"
  "~"
  "<<"
  ">>"
  ; Logical
  "&&"
  "||"
  "!"
] @operator

(conditional_expression
  [
    "?"
    ":"
  ] @keyword.conditional.ternary)

(predicate
  "/" @punctuation.delimiter)
