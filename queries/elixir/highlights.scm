; Punctuation
[
  ","
  ";"
] @punctuation.delimiter

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
  "%"
] @punctuation.special

; Identifiers
(identifier) @variable

; Unused identifiers
((identifier) @comment (#match? @comment 
  "^_"
))

; Comments
(comment) @comment

; Strings
(string) @string

; Modules
(alias) @type

; Atoms & Keywords
[
  (atom)
  (quoted_atom) 
  (keyword)
  (quoted_keyword)
] @symbol

; Interpolation
(interpolation "#{" @string.escape "}" @string.escape)

; Escape sequences
(escape_sequence) @string.escape

; Integers
(integer) @number

; Floats
(float) @float

; Characters
[
  (char)
  (charlist)
] @character

; Booleans
(boolean) @boolean

; Nil
(nil) @constant.builtin

; Operators
(operator_identifier) @operator

(unary_operator
  operator: _ @operator)

(binary_operator
  operator: _ @operator)

(dot
  operator: _ @operator)

(stab_clause
  operator: _ @operator)

; Calling a local function
(call target: (identifier) @function) 

; Calling a remote function
(call target: (dot left: [
  (atom) @type 
  (_)
] right: (identifier) @function) (arguments))

; Calling a local def function
(call target: ((identifier) @keyword.function (#any-of? @keyword.function
  "def"
  "defdelegate"
  "defexception"
  "defguard"
  "defguardp"
  "defimpl"
  "defmacro"
  "defmacrop"
  "defmodule"
  "defn"
  "defnp"
  "defoverridable"
  "defp"
  "defprotocol"
  "defstruct"
)) (arguments [
  (identifier) @function
  (binary_operator left: (identifier) @function operator: "when")
])?)

; Kernel Keywords & Special Forms
(call target: ((identifier) @keyword (#any-of? @keyword
  "alias"
  "case"
  "cond"
  "else"
  "for"
  "if"
  "import"
  "quote"
  "raise"
  "receive"
  "require"
  "reraise"
  "super"
  "throw"
  "try"
  "unless"
  "unquote"
  "unquote_splicing"
  "use"
  "with"
)))

; Special constants
((identifier) @constant.builtin (#any-of? @constant.builtin
  "__CALLER__"
  "__DIR__"
  "__ENV__"
  "__MODULE__"
  "__STACKTRACE__"
))

; Reserved Keywords
[
  "after"
  "and"
  "catch"
  "do"
  "end"
  "fn"
  "in"
  "not"
  "or"
  "rescue" 
  "when"
  "else"
] @keyword

; Capture Operator
(unary_operator
  operator: "&"
  operand: [
    (integer) @operator
    (binary_operator
      left: [
        (call target: (dot left: (_) right: (identifier) @function))
        (identifier) @function
      ]
      operator: "/"
      right: (integer) @operator
    )
])

; Module attributes
(unary_operator 
  operator: "@" @constant 
  operand: [
    (identifier) @constant
    (call target: (identifier) @constant)
])

; Documentation
(unary_operator
  operator: "@" @comment
  operand: (call
    target: ((identifier) @comment) @_identifier
    (arguments
      [
        (string) @comment
        (charlist) @comment
        (sigil
          quoted_start: _ @comment
          quoted_end: _ @comment) @comment
        (boolean) @comment
      ]))
  (#any-of? @_identifier "moduledoc" "typedoc" "doc"))

; Sigils
(sigil 
  "~" @string.special
  ((sigil_name) @string.special) @_sigil_name
  quoted_start: _ @string.special 
  quoted_end: _ @string.special
  ((sigil_modifiers) @string.special)?
  (#not-any-of? @_sigil_name "s" "S"))

(sigil 
  "~" @string
  ((sigil_name) @string) @_sigil_name
  quoted_start: _ @string 
  quoted_end: _ @string
  ((sigil_modifiers) @string)?
  (#any-of? @_sigil_name "s" "S")) @string

; Parser errors
(ERROR) @error
