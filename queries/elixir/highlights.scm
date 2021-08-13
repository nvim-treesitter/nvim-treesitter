(ERROR) @error

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

(interpolation ["#{" "}"] @punctuation.special)

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

[
  (comment) 
  (unused_identifier)
] @comment

[
  (heredoc_content)
  (sigil_content)
  (string)
] @string

; __MODULE__ and friends
(special_identifier) @constant.builtin

(map ["%{" "}"] @constructor)

(struct ["%" "{" "}"] @constructor)

(binary_op operator: _ @operator)

(unary_op operator: _ @operator)

(atom) @symbol

(keyword) @parameter

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

[
  (sigil_start) 
  (sigil_end)
] @string.special

; Module attributes as "attributes"
(unary_op operator: "@" @attribute [
  (call function: (function_identifier) @attribute) 
  (identifier) @attribute
])

; Erlang modules (when they are the remote of a function call) are highlighted as Elixir modules
(dot_call remote: (atom) @type)

(call (function_identifier) @keyword.function (#any-of? @keyword.function 
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
) [(identifier) @function (_)]) ; 0-arity function def without parens

(call (function_identifier) @include (#any-of? @include 
  "alias" 
  "import" 
  "require" 
  "use"
))

(call (function_identifier) @conditional (#any-of? @conditional 
  "case"
  "cond"
  "else"
  "if"
  "unless"
  "with"
  "receive"
))

(call (function_identifier) @exception (#any-of? @exception 
  "raise"
  "reraise"
  "throw"
  "try"
))

(call (function_identifier) @repeat (#any-of? @repeat 
  "for"
))

(call (function_identifier) @keyword.function (#any-of? @keyword.function 
  "describe"
  "setup"
  "setup_all"
  "test"
  "using"
))
