; Copyright 2025 International Digital Economy Academy
;
; Licensed under the Apache License, Version 2.0 (the "License");
; you may not use this file except in compliance with the License.
; You may obtain a copy of the License at
;
;     http://www.apache.org/licenses/LICENSE-2.0
;
; Unless required by applicable law or agreed to in writing, software
; distributed under the License is distributed on an "AS IS" BASIS,
; WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
; See the License for the specific language governing permissions and
; limitations under the License.
; Interpolation
(interpolator) @none

; Packages
(package_identifier) @module

; Variables
; Variables
(parameter
  (parameter_label) @variable.parameter)

(parameter
  (lowercase_identifier) @variable.parameter)

((parameter
  (lowercase_identifier) @variable.builtin)
  (#any-of? @variable.builtin "self"))

(pattern
  (simple_pattern
    (lowercase_identifier) @variable))

(qualified_identifier
  (lowercase_identifier) @variable)

((qualified_identifier
  (lowercase_identifier) @variable.builtin)
  (#any-of? @variable.builtin "self"))

((qualified_identifier
  (dot_identifier) @variable)
  (#lua-match? @variable "^\.[^A-Z]"))

(value_definition
  (lowercase_identifier) @variable)

(let_mut_expression
  (lowercase_identifier) @variable)

; Constants
(const_definition
  (uppercase_identifier) @constant)

((qualified_identifier
  (dot_identifier) @constant)
  (#lua-match? @constant "^\.[A-Z]"))

; Types
; Type identifiers
(type_identifier) @type

(qualified_type_identifier) @type

(constructor_expression
  (uppercase_identifier) @type)

; Type definitions
(enum_definition
  (identifier) @type.definition)

(struct_definition
  (identifier) @type.definition)

(type_definition
  (identifier) @type.definition)

(trait_definition
  (identifier) @type.definition)

(type_alias_definition
  (identifier) @type.definition)

(error_type_definition
  (identifier) @type.definition)

; Builtin types
((qualified_type_identifier) @type.builtin
  (#any-of? @type.builtin
    "Unit" "Bool" "Byte" "Int" "UInt" "Int64" "UInt64" "Float" "Double" "FixedArray" "Array" "Bytes"
    "String" "Error" "Self"))

; Constructors
(enum_constructor) @constant

(constructor_expression
  (uppercase_identifier) @constant)

; Fields
(struct_field_declaration
  (lowercase_identifier) @variable.member)

(struct_field_expressions
  (labeled_expression
    (lowercase_identifier) @variable.member))

(struct_field_expressions
  (labeled_expression_pun
    (lowercase_identifier) @variable.member))

(struct_field_expression
  (labeled_expression
    (lowercase_identifier) @variable.member))

(struct_field_expression
  (labeled_expression_pun
    (lowercase_identifier) @variable.member))

(struct_field_pattern
  (field_single_pattern
    (labeled_pattern
      (lowercase_identifier) @variable.member)))

(struct_field_pattern
  (field_single_pattern
    (labeled_pattern_pun
      (lowercase_identifier) @variable.member)))

(access_expression
  (accessor
    (dot_identifier) @variable.member))

; Functions
; Function calls
(apply_expression
  (simple_expression
    (qualified_identifier) @function.call))

; Method calls
(method_expression
  (lowercase_identifier) @function.method.call)

(dot_apply_expression
  (dot_identifier) @function.method.call)

; Function definitions
(function_definition
  (function_identifier
    (lowercase_identifier) @function))

(trait_method_declaration
  (function_identifier) @function)

(impl_definition
  (function_identifier) @function)

; Method definitions
(function_definition
  (function_identifier
    (qualified_type_identifier)
    (lowercase_identifier) @function.method))

; Labels
(loop_label) @label

("continue"
  (parameter_label) @label)

("break"
  (parameter_label) @label)

; Operators
[
  "+"
  "-"
  "*"
  "/"
  "%"
  "="
  "<"
  ">"
  ">="
  "<="
  "=="
  "!="
  "&&"
  "||"
  "=>"
  "->"
  "!"
  "!!"
] @operator

; Keywords
(mutability) @keyword.modifier

[
  "struct"
  "enum"
  "type"
  "trait"
  "typealias"
] @keyword.type

[
  "pub"
  "priv"
  "readonly"
  "all"
  "open"
  "extern"
] @keyword.modifier

[
  "guard"
  "let"
  "mut"
  "const"
  "with"
] @keyword

(derive) @keyword

[
  "fn"
  "test"
  "impl"
] @keyword.function

"return" @keyword.return

[
  "while"
  "loop"
  "for"
  "break"
  "continue"
  "in"
] @keyword.repeat

[
  "if"
  "else"
  "match"
] @keyword.conditional

"async" @keyword.coroutine

[
  "try"
  "raise"
  "catch"
] @keyword.exception

; Delimiters
[
  ";"
  ","
] @punctuation.delimiter

(colon) @punctuation.delimiter

(colon_colon) @punctuation.delimiter

(dot_operator) @punctuation.delimiter

(dot_dot) @punctuation.delimiter

[
  "("
  ")"
  "{"
  "}"
  "["
  "]"
] @punctuation.bracket

; Literals
(string_interpolation) @string

(string_literal) @string

(multiline_string_literal) @string

(escape_sequence) @string.escape

(interpolator
  "\\{" @punctuation.special
  "}" @punctuation.special)

(integer_literal) @number

(float_literal) @number.float

(boolean_literal) @boolean

; Comments
(comment) @comment @spell

(docstring) @comment.documentation @spell
