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

; Kernel Functions, Guards, & Special Forms
((function_identifier) @keyword.function
(#any-of? @keyword.function 
  "alias!"
  "apply"
  "binding"
  "case"
  "cond"
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
  "destructure"
  "exit"
  "fn"
  "for"
  "function_exported?"
  "get_and_update_in"
  "get_in"
  "if"
  "inspect"
  "macro_exported?"
  "make_ref"
  "match?"
  "max"
  "min"
  "pop_in"
  "put_elem"
  "put_in"
  "quote"
  "raise"
  "receive"
  "reraise"
  "send"
  "spawn"
  "spawn_link"
  "spawn_monitor"
  "struct!"
  "struct"
  "super"
  "tap"
  "then"
  "throw"
  "to_charlist"
  "to_string"
  "try"
  "unless"
  "unquote"
  "unquote_splicing"
  "update_in"
  "var!"
  "with"
  "abs"
  "and"
  "binary_part"
  "bit_size"
  "byte_size"
  "ceil"
  "div"
  "elem"
  "floor"
  "hd"
  "in"
  "is_atom"
  "is_binary"
  "is_bitstring"
  "is_boolean"
  "is_exception"
  "is_float"
  "is_function"
  "is_integer"
  "is_list"
  "is_map"
  "is_map_key"
  "is_nil"
  "is_number"
  "is_pid"
  "is_port"
  "is_reference"
  "is_struct"
  "is_tuple"
  "length"
  "map_size"
  "node"
  "not"
  "or"
  "rem"
  "round"
  "self"
  "tl"
  "trunc"
  "tuple_size"
))

((function_identifier) @include
(#any-of? @include 
  "alias" 
  "import" 
  "require" 
  "use"
))
