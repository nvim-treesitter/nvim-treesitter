
; ==============================================================================
; @definition            ; various definitions

(block
  label: [
    (identifier) @definition
    (accent_quoted) @definition
  ])

; ==============================================================================
; @definition.constant   ; constants

(const_section
  (variable_declaration
    (symbol_declaration_list
      (symbol_declaration
        name: [
          (identifier) @definition.constant
          (accent_quoted) @definition.constant
          (exported_symbol (identifier) @definition.constant)
          (exported_symbol (accent_quoted) @definition.constant)
        ]))
    type: (type_expression)? @definition.associated))

; ==============================================================================
; @definition.function   ; functions

(proc_declaration
  name: [
    (identifier) @definition.function
    (accent_quoted) @definition.function
    (exported_symbol (identifier) @definition.function)
    (exported_symbol (accent_quoted) @definition.function)
  ]
  (#set! "definition.function.scope" "parent"))

(func_declaration
  name: [
    (identifier) @definition.function
    (accent_quoted) @definition.function
    (exported_symbol (identifier) @definition.function)
    (exported_symbol (accent_quoted) @definition.function)
  ]
  (#set! "definition.function.scope" "parent"))

(iterator_declaration
  name: [
    (identifier) @definition.function
    (accent_quoted) @definition.function
    (exported_symbol (identifier) @definition.function)
    (exported_symbol (accent_quoted) @definition.function)
  ]
  (#set! "definition.function.scope" "parent"))

(converter_declaration
  name: [
    (identifier) @definition.function
    (accent_quoted) @definition.function
    (exported_symbol (identifier) @definition.function)
    (exported_symbol (accent_quoted) @definition.function)
  ]
  (#set! "definition.function.scope" "parent"))

; ==============================================================================
; @definition.method     ; methods

(method_declaration
  name: [
    (identifier) @definition.method
    (accent_quoted) @definition.method
    (exported_symbol (identifier) @definition.method)
    (exported_symbol (accent_quoted) @definition.method)
  ]
  (#set! "definition.method.scope" "parent"))

; ==============================================================================
; @definition.var        ; variables

(var_section
  (variable_declaration
    (symbol_declaration_list
      (symbol_declaration
        name: [
          (identifier) @definition.var
          (accent_quoted) @definition.var
          (exported_symbol (identifier) @definition.var)
          (exported_symbol (accent_quoted) @definition.var)
        ]))
    type: (type_expression)? @definition.associated))

(let_section
  (variable_declaration
    (symbol_declaration_list
      (symbol_declaration
        name: [
          (identifier) @definition.var
          (accent_quoted) @definition.var
          (exported_symbol (identifier) @definition.var)
          (exported_symbol (accent_quoted) @definition.var)
        ]))
    type: (type_expression)? @definition.associated))

(for
  (symbol_declaration_list
    (symbol_declaration
      name: [
        (identifier) @definition.var
        (accent_quoted) @definition.var
      ])))

(try
  (except_branch
    values: (expression_list
      (infix_expression
        right: [
          (identifier) @definition.var
          (accent_quoted) @definition.var
        ]))))

; ==============================================================================
; @definition.parameter  ; parameters

(parameter_declaration
  (symbol_declaration_list
    (symbol_declaration
      name: [
        (identifier) @definition.parameter
        (accent_quoted) @definition.parameter
      ]))
  type: (type_expression)? @definition.associated)

(concept_declaration
  parameters:
    (parameter_list [
      (identifier) @definition.parameter
      (accent_quoted (identifier) @definition.parameter)
    ]))
(var_parameter [
  (identifier) @definition.parameter
  (accent_quoted (identifier) @definition.parameter)
])
(type_parameter [
  (identifier) @definition.parameter
  (accent_quoted (identifier) @definition.parameter)
])
(static_parameter [
  (identifier) @definition.parameter
  (accent_quoted (identifier) @definition.parameter)
])
(ref_parameter [
  (identifier) @definition.parameter
  (accent_quoted (identifier) @definition.parameter)
])
(pointer_parameter [
  (identifier) @definition.parameter
  (accent_quoted (identifier) @definition.parameter)
])

; ==============================================================================
; @definition.macro      ; preprocessor macros

(template_declaration
  name: [
    (identifier) @definition.macro
    (accent_quoted) @definition.macro
    (exported_symbol (identifier) @definition.macro)
    (exported_symbol (accent_quoted) @definition.macro)
  ]
  (#set! "definition.macro.scope" "parent"))

(macro_declaration
  name: [
    (identifier) @definition.macro
    (accent_quoted) @definition.macro
    (exported_symbol (identifier) @definition.macro)
    (exported_symbol (accent_quoted) @definition.macro)
  ]
  (#set! "definition.macro.scope" "parent"))

; ==============================================================================
; @definition.type       ; types or classes

(type_declaration
  (type_symbol_declaration
    name: [
      (identifier) @definition.type
      (accent_quoted) @definition.type
      (exported_symbol (identifier) @definition.type)
      (exported_symbol (accent_quoted) @definition.type)
    ]))

; ==============================================================================
; @definition.field      ; fields or properties

; object_declaration
; variant_declaration
; conditional_declaration
; tuple_type inline
; tuple_type multiline
(field_declaration
  (symbol_declaration_list
    (symbol_declaration
      name: [
        (identifier) @definition.field
        (accent_quoted) @definition.field
        (exported_symbol (identifier) @definition.field)
        (exported_symbol (accent_quoted) @definition.field)
      ]))
  type: (type_expression)? @definition.associated)

; ==============================================================================
; @definition.enum       ; enumerations

(enum_declaration
  (enum_field_declaration
    (symbol_declaration
      name: [
        (identifier) @definition.enum
        (accent_quoted) @definition.enum
      ])))

; ==============================================================================
; @definition.namespace  ; modules or namespaces
; @definition.import     ; imported names

(import_statement
  (expression_list
    (identifier) @definition.namespace))

(import_statement
  (expression_list
    (infix_expression
      operator: "as"
      right: (identifier) @definition.namespace)))

(import_statement
  (expression_list
    (infix_expression
      operator: (operator) @_operator
      right: [
        (identifier) @definition.namespace
        (array_construction (identifier) @definition.namespace)
      ]))
  (#eq? @_operator "/"))

(import_from_statement
  module: (infix_expression
    operator: (operator) @_operator
    right: (identifier) @definition.namespace)
  (expression_list [
    (identifier) @definition.import
    (accent_quoted) @definition.import
  ])
  (#eq? @_operator "/"))

; ==============================================================================
; @scope                 ; scope block

; (when)
; NOTE: `when` does actually not create a scope

(if
  consequence: (statement_list) @scope
  alternative: (elif_branch)* @scope
  alternative: (else_branch)? @scope)

(case
  alternative: (of_branch)* @scope
  alternative: (elif_branch)* @scope
  alternative: (else_branch)? @scope)

(try
  body: (statement_list) @scope
  (except_branch) @scope
  (finally_branch)? @scope)

[
  (for)
  (while)
  (block)
  (static_statement)

  (proc_declaration)
  (func_declaration)
  (method_declaration)
  (iterator_declaration)
  (converter_declaration)
  (template_declaration)
  (macro_declaration)

  (proc_expression)
  (func_expression)
  (iterator_expression)

  (concept_declaration)
] @scope

; ==============================================================================
; @reference             ; identifier reference

(identifier) @reference
(accent_quoted) @reference
