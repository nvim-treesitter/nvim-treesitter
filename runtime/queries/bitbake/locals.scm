; References
[
  (python_identifier)
  (identifier)
] @local.reference

; Imports
(aliased_import
  alias: (python_identifier) @local.definition.import)

(import_statement
  name:
    (dotted_name
      (python_identifier) @local.definition.import))

(import_from_statement
  name:
    (dotted_name
      (python_identifier) @local.definition.import))

; Function with parameters, defines parameters
(parameters
  (python_identifier) @local.definition.parameter)

(default_parameter
  (python_identifier) @local.definition.parameter)

(typed_parameter
  (python_identifier) @local.definition.parameter)

(typed_default_parameter
  (python_identifier) @local.definition.parameter)

; *args parameter
(parameters
  (list_splat_pattern
    (python_identifier) @local.definition.parameter))

; **kwargs parameter
(parameters
  (dictionary_splat_pattern
    (python_identifier) @local.definition.parameter))

; Function defines function and scope
((python_function_definition
  name: (python_identifier) @local.definition.function) @local.scope
  (#set! definition.function.scope "parent"))

(function_definition
  (identifier) @local.definition.function)

(anonymous_python_function
  (identifier) @local.definition.function)

; Loops
; not a scope!
(for_statement
  left:
    (pattern_list
      (python_identifier) @local.definition.var))

(for_statement
  left:
    (tuple_pattern
      (python_identifier) @local.definition.var))

(for_statement
  left: (python_identifier) @local.definition.var)

; not a scope!
;(while_statement) @local.scope
; for in list comprehension
(for_in_clause
  left: (python_identifier) @local.definition.var)

(for_in_clause
  left:
    (tuple_pattern
      (python_identifier) @local.definition.var))

(for_in_clause
  left:
    (pattern_list
      (python_identifier) @local.definition.var))

(dictionary_comprehension) @local.scope

(list_comprehension) @local.scope

(set_comprehension) @local.scope

; Assignments
(assignment
  left: (python_identifier) @local.definition.var)

(assignment
  left:
    (pattern_list
      (python_identifier) @local.definition.var))

(assignment
  left:
    (tuple_pattern
      (python_identifier) @local.definition.var))

(assignment
  left:
    (attribute
      (python_identifier)
      (python_identifier) @local.definition.field))

(variable_assignment
  (identifier)
  operator:
    [
      "="
      "?="
      "??="
      ":="
    ] @local.definition.var)

; Walrus operator  x := 1
(named_expression
  (python_identifier) @local.definition.var)

(as_pattern
  alias: (as_pattern_target) @local.definition.var)
