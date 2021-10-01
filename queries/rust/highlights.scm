; Forked from https://github.com/tree-sitter/tree-sitter-rust
; Copyright (c) 2017 Maxim Sokolov
; Licensed under the MIT license.

; Identifier conventions

(identifier) @variable
(const_item
  name: (identifier) @constant)
; Assume all-caps names are constants
((identifier) @constant
 (#match? @constant "^[A-Z][A-Z\\d_]*$"))

; Other identifiers

(type_identifier) @type
(primitive_type) @type.builtin
(field_identifier) @field
(shorthand_field_initializer
  (identifier) @field)
(mod_item
 name: (identifier) @namespace)

; Function calls
(call_expression
  function: (identifier) @function)
(call_expression
  function: (scoped_identifier
              (identifier) @function .))
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
((field_identifier) @constant
 (#match? @constant "^[A-Z]"))

(enum_variant
  name: (identifier) @constant)

; Assume that uppercase names in paths are types
(scoped_identifier
  path: (identifier) @namespace)
(scoped_identifier
 (scoped_identifier
  name: (identifier) @namespace))
(scoped_type_identifier
  path: (identifier) @namespace)
(scoped_type_identifier
 (scoped_identifier
  name: (identifier) @namespace))
((scoped_identifier
  path: (identifier) @type)
 (#match? @type "^[A-Z]"))
((scoped_identifier
    name: (identifier) @type)
 (#match? @type "^[A-Z]"))

(crate) @namespace
(scoped_use_list
  path: (identifier) @namespace)
(scoped_use_list
  path: (scoped_identifier
            (identifier) @namespace))
(use_list (scoped_identifier (identifier) @namespace . (_)))
(use_list (identifier) @type (#match? @type "^[A-Z]"))
(use_as_clause alias: (identifier) @type (#match? @type "^[A-Z]"))

;; Correct enum constructors
(call_expression
  function: (scoped_identifier
    "::"
    name: (identifier) @constant)
  (#match? @constant "^[A-Z]"))

;; Macro definitions
"$" @function.macro
(metavariable) @function.macro

;; Attribute macros
(attribute_item (meta_item (identifier) @function.macro))
(meta_item (scoped_identifier (identifier) @function.macro .))

;; Derive macros (assume all arguments are types)
(meta_item
  (identifier) @_name
  arguments: (meta_arguments (meta_item (identifier) @type))
  (#eq? @_name "derive"))

;; Function-like macros
(macro_invocation
  macro: (identifier) @function.macro)
(macro_invocation
  macro: (scoped_identifier
           (identifier) @function.macro .))



; Function definitions

(function_item (identifier) @function)
(function_signature_item (identifier) @function)

[
(line_comment)
(block_comment)
 ] @comment

(parameter (identifier) @parameter)
(closure_parameters (_) @parameter)

(lifetime (identifier) @label)
(loop_label (identifier) @label)

(self) @variable.builtin

[
 "use"
 "mod"
] @include

[
"break"
"const"
"default"
"dyn"
"enum"
"extern"
"impl"
"let"
"macro_rules!"
"match"
"move"
"pub"
"ref"
"static"
"struct"
"trait"
"type"
"union"
"unsafe"
"async"
"await"
"where"
(mutable_specifier)
(super)
] @keyword

"return" @keyword.return

"fn" @keyword.function

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
] @keyword.operator

[
"*"
"'"
"->"
"=>"
"<="
"="
"=="
"!"
"!="
"%"
"%="
"&"
"&="
"&&"
"|"
"|="
"||"
"^"
"^="
"*"
"*="
"-"
"-="
"+"
"+="
"/"
"/="
">"
"<"
">="
">>"
"<<"
">>="
"@"
".."
"..="
"?"
] @operator

[
 "("
 ")"
 "["
 "]"
 "{"
 "}"
] @punctuation.bracket

(closure_parameters "|" @punctuation.bracket)

(type_arguments
  "<" @punctuation.bracket
  ">" @punctuation.bracket)
(type_parameters
  "<" @punctuation.bracket
  ">" @punctuation.bracket)

[
":"
"::"
"."
";"
","
] @punctuation.delimiter

(attribute_item "#" @punctuation.special)
(inner_attribute_item ["#" "!"] @punctuation.special)
(macro_invocation "!" @function.macro) ; don't highlight `!` as an operator here
