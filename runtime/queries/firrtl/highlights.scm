; Namespaces
(circuit
  (identifier) @module)

(module
  (identifier) @module)

; Types
((identifier) @type
  (#lua-match? @type "^[A-Z][A-Za-z0-9_$]*$"))

; Keywords
[
  "circuit"
  "module"
  "extmodule"
  "flip"
  "parameter"
  "reset"
  "wire"
  "cmem"
  "smem"
  "mem"
  "reg"
  "with"
  "mport"
  "inst"
  "of"
  "node"
  "is"
  "invalid"
  "skip"
  "infer"
  "read"
  "write"
  "rdwr"
  "defname"
] @keyword

; Qualifiers
(qualifier) @keyword.modifier

; Storageclasses
[
  "input"
  "output"
] @keyword.modifier

; Conditionals
[
  "when"
  "else"
] @keyword.conditional

; Annotations
(info) @attribute

; Builtins
[
  "stop"
  "printf"
  "assert"
  "assume"
  "cover"
  "attach"
  "mux"
  "validif"
] @function.builtin

[
  "UInt"
  "SInt"
  "Analog"
  "Fixed"
  "Clock"
  "AsyncReset"
  "Reset"
] @type.builtin

; Fields
[
  "data-type"
  "depth"
  "read-latency"
  "write-latency"
  "read-under-write"
  "reader"
  "writer"
  "readwriter"
] @variable.member

((field_id) @variable.member
  (#set! priority 105))

(port
  (identifier) @variable.member)

(wire
  (identifier) @variable.member)

(cmem
  (identifier) @variable.member)

(smem
  (identifier) @variable.member)

(memory
  (identifier) @variable.member)

(register
  (identifier) @variable.member)

; Parameters
(primitive_operation
  (identifier) @variable.parameter)

(mux
  (identifier) @variable.parameter)

(printf
  (identifier) @variable.parameter)

(reset
  (identifier) @variable.parameter)

(stop
  (identifier) @variable.parameter)

; Variables
(identifier) @variable

; Operators
(primop) @keyword.operator

[
  "+"
  "-"
  "="
  "=>"
  "<="
  "<-"
] @operator

; Literals
[
  (uint)
  (number)
] @number

(number_str) @string.special

(double) @number.float

(string) @string

(escape_sequence) @string.escape

[
  "old"
  "new"
  "undefined"
] @constant.builtin

; Punctuation
[
  "{"
  "}"
] @punctuation.bracket

[
  "["
  "]"
] @punctuation.bracket

[
  "<"
  ">"
] @punctuation.bracket

[
  "("
  ")"
] @punctuation.bracket

[
  ","
  "."
  ":"
] @punctuation.delimiter

; Comments
(comment) @comment @spell

[
  "=>"
  "<="
  "="
] @operator
