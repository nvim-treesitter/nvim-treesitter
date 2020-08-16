; Forked from https://github.com/tree-sitter/tree-sitter-rust
; Copyright (c) 2017 Maxim Sokolov
; Licensed under the MIT license.

; Identifier conventions

; Assume all-caps names are constants
((identifier) @constant
 (#vim-match? @constant "^[A-Z][A-Z\\d_]+$'"))

; Other identifiers

(type_identifier) @type
(primitive_type) @type.builtin
(field_identifier) @field


; Function calls
(call_expression
  function: (identifier) @function)
(call_expression
  function: (field_expression
    field: (field_identifier) @function))

(generic_function
  function: (identifier) @function)
(generic_function
  function: (scoped_identifier
    name: (identifier) @function))
(generic_function
  function: (field_expression
    field: (field_identifier) @function))

; Assume other uppercase names are enum constructors
([(identifier) (field_identifier)] @constant
 (#match? @constant "^[A-Z]"))

; Assume that uppercase names in paths are types
((scoped_identifier
  path: (identifier) @type)
 (#match? @type "^[A-Z]"))
((scoped_identifier
    name: (identifier) @type)
 (#match? @type "^[A-Z]"))

(use_list (identifier) @type (#match? @type "^[A-Z]"))
(use_as_clause alias: (identifier) @type (#match? @type "^[A-Z]"))

;; Correct enum constructors
(call_expression
  function: (scoped_identifier
    "::"
    name: (identifier) @constant)
  (#match? @constant "^[A-Z]"))

;; Assume that all `#[derive]` arguments are types
(meta_item
  (identifier) @meta
  arguments: (meta_arguments (meta_item (identifier) @type))
  (#eq? @meta "derive"))

(macro_invocation
  macro: (identifier) @function.macro
  "!" @function.macro)

; Function definitions

(function_item (identifier) @function)
(function_signature_item (identifier) @function)

[
(line_comment)
(block_comment)
 ] @comment

[
"("
")"
"["
"]"
 ] @punctuation.bracket

(type_arguments
  "<" @punctuation.bracket
  ">" @punctuation.bracket)
(type_parameters
  "<" @punctuation.bracket
  ">" @punctuation.bracket)

[
"::"
"."
";"
 ] @punctuation.delimiter

(parameter (identifier) @parameter)

(lifetime (identifier) @label)

(self) @variable.builtin

[
"break"
"const"
"default"
"dyn"
"enum"
"extern"
"fn"
"impl"
"let"
"macro_rules!"
"match"
"mod"
"move"
"pub"
"ref"
"return"
"static"
"struct"
"trait"
"type"
"union"
"unsafe"
"async"
"await"
"use"
"where"
(mutable_specifier)
(super)
; TODO(vigoux): attribute items should have some kind of injections
(attribute_item)
(inner_attribute_item)
 ] @keyword

(use_list (self) @keyword)
(scoped_use_list (self) @keyword)
(scoped_identifier (self) @keyword)

[
"continue"
"else"
"if"
] @conditional

[
"for"
"in"
"loop"
"while"
] @repeat

[
(char_literal)
(string_literal)
(raw_string_literal)
] @string

(boolean_literal) @boolean
(integer_literal) @number
(float_literal) @float

(escape_sequence) @string.escape

[
"as"
"*"
"&"
"'"
 ] @operator

(closure_parameters "|" @operator "|" @operator)
