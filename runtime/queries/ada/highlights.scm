; highlight queries.
; See the syntax at https://tree-sitter.github.io/tree-sitter/using-parsers#pattern-matching-with-queries
; See also https://github.com/nvim-treesitter/nvim-treesitter/blob/master/CONTRIBUTING.md#parser-configurations
; for a list of recommended @ tags, though not all of them have matching
; highlights in neovim.
[
  "abort"
  "abs"
  "abstract"
  "accept"
  "access"
  "all"
  "array"
  "at"
  "begin"
  "body"
  "declare"
  "delay"
  "delta"
  "digits"
  "do"
  "end"
  "entry"
  "exit"
  "generic"
  "interface"
  "is"
  "limited"
  "mod"
  "new"
  "null"
  "of"
  "others"
  "out"
  "overriding"
  "package"
  "pragma"
  "private"
  "protected"
  "range"
  "separate"
  "subtype"
  "synchronized"
  "tagged"
  "task"
  "terminate"
  "type"
  "until"
  "when"
] @keyword

"record" @keyword.type

[
  "aliased"
  "constant"
  "renames"
] @keyword.modifier

[
  "with"
  "use"
] @keyword.import

[
  "function"
  "procedure"
] @keyword.function

[
  "and"
  "in"
  "not"
  "or"
  "xor"
] @keyword.operator

[
  "while"
  "loop"
  "for"
  "parallel"
  "reverse"
  "some"
] @keyword.repeat

"return" @keyword.return

[
  "case"
  "if"
  "else"
  "then"
  "elsif"
  "select"
] @keyword.conditional

[
  "exception"
  "raise"
] @keyword.exception

(comment) @comment @spell

(string_literal) @string

(character_literal) @string

(numeric_literal) @number

; Highlight the name of subprograms
(procedure_specification
  name: (_) @function)

(function_specification
  name: (_) @function)

(package_declaration
  name: (_) @function)

(package_body
  name: (_) @function)

(generic_instantiation
  name: (_) @function)

(entry_declaration
  .
  (identifier) @function)

; Some keywords should take different categories depending on the context
(use_clause
  "use" @keyword.import
  "type" @keyword.import)

(with_clause
  "private" @keyword.import)

(with_clause
  "limited" @keyword.import)

(use_clause
  (_) @module)

(with_clause
  (_) @module)

(loop_statement
  "end" @keyword.repeat)

(if_statement
  "end" @keyword.conditional)

(loop_parameter_specification
  "in" @keyword.repeat)

(loop_parameter_specification
  "in" @keyword.repeat)

(iterator_specification
  [
    "in"
    "of"
  ] @keyword.repeat)

(range_attribute_designator
  "range" @keyword.repeat)

(raise_statement
  "with" @keyword.exception)

(gnatprep_declarative_if_statement) @keyword.directive

(gnatprep_if_statement) @keyword.directive

(gnatprep_identifier) @keyword.directive

(subprogram_declaration
  "is" @keyword.function
  "abstract" @keyword.function)

(aspect_specification
  "with" @keyword.function)

(full_type_declaration
  "is" @keyword.type)

(subtype_declaration
  "is" @keyword.type)

(record_definition
  "end" @keyword.type)

(full_type_declaration
  (_
    "access" @keyword.type))

(array_type_definition
  "array" @keyword.type
  "of" @keyword.type)

(access_to_object_definition
  "access" @keyword.type)

(access_to_object_definition
  "access" @keyword.type
  [
    (general_access_modifier
      "constant" @keyword.type)
    (general_access_modifier
      "all" @keyword.type)
  ])

(range_constraint
  "range" @keyword.type)

(signed_integer_type_definition
  "range" @keyword.type)

(index_subtype_definition
  "range" @keyword.type)

(record_type_definition
  "abstract" @keyword.type)

(record_type_definition
  "tagged" @keyword.type)

(record_type_definition
  "limited" @keyword.type)

(record_type_definition
  (record_definition
    "null" @keyword.type))

(private_type_declaration
  "is" @keyword.type
  "private" @keyword.type)

(private_type_declaration
  "tagged" @keyword.type)

(private_type_declaration
  "limited" @keyword.type)

(task_type_declaration
  "task" @keyword.type
  "is" @keyword.type)

; Gray the body of expression functions
(expression_function_declaration
  (function_specification)
  "is"
  (_) @attribute)

(subprogram_declaration
  (aspect_specification) @attribute)

; Highlight full subprogram specifications
;(subprogram_body
;    [
;       (procedure_specification)
;       (function_specification)
;    ] @function.spec
;)
((comment) @comment.documentation
  .
  [
    (entry_declaration)
    (subprogram_declaration)
    (parameter_specification)
  ])

(compilation_unit
  .
  (comment) @comment.documentation)

(component_list
  (component_declaration)
  .
  (comment) @comment.documentation)

(enumeration_type_definition
  (identifier)
  .
  (comment) @comment.documentation)
