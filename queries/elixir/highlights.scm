; Parser errors
(ERROR) @error

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
  "->"
  "."
] @punctuation.delimiter

[
  (sigil_start)
  (sigil_end)
  (heredoc_start)
  (heredoc_end)
] @punctuation.special

; String interpolation
(interpolation "#{" @punctuation.special "}" @punctuation.special)

; Literal keywords
[
  "after"
  "and" 
  "catch"
  "do"
  "else"
  "end"
  "fn"
  "in"
  "not in"
  "not"
  "or"
  "rescue"
  "when" 
] @keyword

; Comments and unused identifiers
[
  (comment) 
  (unused_identifier)
] @comment

; Strings and heredocs
[
  (heredoc_content)
  (sigil_content)
  (string)
] @string

; __MODULE__ and friends
(special_identifier) @constant.builtin

; Maps
(map "%{" @constructor "}" @constructor)

; Structs
(struct "%" @constructor "{" @constructor "}" @constructor)

; Binary operators
(binary_op operator: _ @operator)

; Unary operators
(unary_op operator: _ @operator)

; Atoms and Keywords
(atom) @symbol

(keyword) @parameter

; Booleans
[
  (true) 
  (false)
] @boolean

(nil) @constant.builtin

(sigil) @string.special

(identifier) @variable

(module) @type

(function_identifier) @function

(integer) @number

(float) @float

[(sigil_start) (sigil_end)] @string.special

; Module attributes as "attributes"
(unary_op
 operator: "@" @attribute
 [(call
   function: (function_identifier) @attribute)
  (identifier) @attribute])

; Erlang modules are highlighted as Elixir modules
(dot_call remote: (atom) @type)

; def and friends
((function_identifier) @keyword.function
(#any-of? @keyword.function 
  "def"
  "defdelegate"
  "defexception"
  "defguard"
  "defguardp"
  "defimpl"
  "defmacro"
  "defmacrop"
  "defmodule"
  "defoverridable"
  "defp"
  "defprotocol"
  "defstruct"
))

((function_identifier) @include
(#any-of? @include 
  "alias" 
  "import" 
  "require" 
  "use"
))

((function_identifier) @conditional
(#any-of? @conditional 
  "case"
  "cond"
  "else"
  "if"
  "unless"
  "with"
  "receive"
))

((function_identifier) @exception
(#any-of? @exception 
  "raise"
  "reraise"
  "throw"
  "try"
))

((function_identifier) @repeat
(#any-of? @repeat 
  "for"
))

; ExUnit
;((function_identifier) @keyword.function
;(#any-of? @keyword.function 
;  "describe"
;  "setup"
;  "setup_all"
;  "test"
;  "using"
;))
