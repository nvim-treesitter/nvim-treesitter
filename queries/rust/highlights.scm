; Forked from https://github.com/tree-sitter/tree-sitter-rust
; Copyright (c) 2017 Maxim Sokolov
; Licensed under the MIT license.

; Identifier conventions

; Assume all-caps names are constants
((identifier) @constant
 (match? @constant "^[A-Z][A-Z\\d_]+$'"))


; Function calls
(call_expression
  function: (identifier) @function)
(call_expression
  function: (field_expression
    field: (field_identifier) @method))
(call_expression
  function: (scoped_identifier
    "::"
    name: (identifier) @function))

(generic_function
  function: (identifier) @function)
(generic_function
  function: (scoped_identifier
    name: (identifier) @function))
(generic_function
  function: (field_expression
    field: (field_identifier) @method))

; Assume other uppercase names are enum constructors
((identifier) @constructor
 (match? @constructor "^[A-Z]"))

; Assume that uppercase names in paths are types
((scoped_identifier
  path: (identifier) @type)
 (match? @type "^[A-Z]"))
((scoped_identifier
    name: (identifier) @type)
 (match? @type "^[A-Z]"))

(macro_invocation
  macro: (identifier) @function.macro
  "!" @function.macro)

; Function definitions

(function_item (identifier) @function)
(function_signature_item (identifier) @function)

; Other identifiers

(type_identifier) @type
(primitive_type) @type.builtin
(field_identifier) @field

(line_comment) @comment
(block_comment) @comment

"(" @punctuation.bracket
")" @punctuation.bracket
"[" @punctuation.bracket
"]" @punctuation.bracket

(type_arguments
  "<" @punctuation.bracket
  ">" @punctuation.bracket)
(type_parameters
  "<" @punctuation.bracket
  ">" @punctuation.bracket)

"::" @punctuation.delimiter
"." @punctuation.delimiter
";" @punctuation.delimiter

(parameter (identifier) @parameter)

(lifetime (identifier) @label)

"break" @keyword
"const" @keyword
"continue" @conditional
"default" @keyword
"dyn" @keyword
"else" @conditional
"enum" @keyword
"extern" @keyword
"fn" @keyword
"for" @repeat
"if" @conditional
"impl" @keyword
"in" @repeat
"let" @keyword
"loop" @repeat
"macro_rules!" @keyword
"match" @keyword
"mod" @keyword
"move" @keyword
"pub" @keyword
"ref" @keyword
"return" @keyword
"static" @keyword
"struct" @structure
"trait" @keyword
"type" @keyword
"union" @keyword
"unsafe" @keyword
"use" @keyword
"where" @keyword
"while" @repeat
(mutable_specifier) @keyword
(use_list (self) @keyword)
(scoped_use_list (self) @keyword)
(scoped_identifier (self) @keyword)
(super) @keyword

(self) @variable.builtin

(char_literal) @string
(string_literal) @string
(raw_string_literal) @string

(boolean_literal) @boolean
(integer_literal) @number
(float_literal) @float

(escape_sequence) @string.escape

; TODO(vigoux): attribute items should have some kind of injections
(attribute_item) @keyword
(inner_attribute_item) @keyword

"as" @operator
"*" @operator
"&" @operator
"'" @operator
(closure_parameters "|" @operator "|" @operator)
