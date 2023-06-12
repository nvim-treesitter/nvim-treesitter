; Program structure
(module) @local.scope

; Function with parameters, defines parameters
(parameters
  (identifier) @local.definition.parameter)

(default_parameter
  (identifier) @local.definition.parameter)

(typed_parameter
  (identifier) @local.definition.parameter)

(typed_default_parameter
  (identifier) @local.definition.parameter)

; *args parameter
(parameters
  (list_splat_pattern
    (identifier) @local.definition.parameter))

; **kwargs parameter
(parameters
  (dictionary_splat_pattern
    (identifier) @local.definition.parameter))

; Function defines function and scope
((function_definition
  name: (identifier) @local.definition.function) @local.scope
  (#set! definition.function.scope "parent"))

; Loops
; not a scope!
(for_statement
  left: (pattern_list
    (identifier) @local.definition.var))

(for_statement
  left: (tuple_pattern
    (identifier) @local.definition.var))

(for_statement
  left: (identifier) @local.definition.var)

; for in list comprehension
(for_in_clause
  left: (identifier) @local.definition.var)

(for_in_clause
  left: (tuple_pattern
    (identifier) @local.definition.var))

(for_in_clause
  left: (pattern_list
    (identifier) @local.definition.var))

(dictionary_comprehension) @local.scope

(list_comprehension) @local.scope

(set_comprehension) @local.scope

; Assignments
(assignment
  left: (identifier) @local.definition.var)

(assignment
  left: (pattern_list
    (identifier) @local.definition.var))

(assignment
  left: (tuple_pattern
    (identifier) @local.definition.var))

(assignment
  left: (attribute
    (identifier)
    (identifier) @local.definition.field))

; Walrus operator  x := 1
(named_expression
  (identifier) @local.definition.var)

(as_pattern
  alias: (as_pattern_target) @local.definition.var)

; REFERENCES
(identifier) @local.reference

; Starlark-specific
; Loads
((call
  function: (identifier) @_fn
  arguments: (argument_list
    (string) @local.definition.import))
  (#eq? @_fn "load"))
