; ==============================================================================
; @local.definition            ; various definitions
(block
  label: [
    (identifier) @local.definition
    (accent_quoted) @local.definition
  ])

; ==============================================================================
; @local.definition.constant   ; constants
(const_section
  (variable_declaration
    (symbol_declaration_list
      (symbol_declaration
        name: [
          (identifier) @local.definition.constant
          (accent_quoted) @local.definition.constant
          (exported_symbol
            (identifier) @local.definition.constant)
          (exported_symbol
            (accent_quoted) @local.definition.constant)
        ]))
    type: (type_expression)? @local.definition.associated))

; ==============================================================================
; @local.definition.function   ; functions
(proc_declaration
  name: [
    (identifier) @local.definition.function
    (accent_quoted) @local.definition.function
    (exported_symbol
      (identifier) @local.definition.function)
    (exported_symbol
      (accent_quoted) @local.definition.function)
  ]
  (#set! "definition.function.scope" "parent"))

(func_declaration
  name: [
    (identifier) @local.definition.function
    (accent_quoted) @local.definition.function
    (exported_symbol
      (identifier) @local.definition.function)
    (exported_symbol
      (accent_quoted) @local.definition.function)
  ]
  (#set! "definition.function.scope" "parent"))

(iterator_declaration
  name: [
    (identifier) @local.definition.function
    (accent_quoted) @local.definition.function
    (exported_symbol
      (identifier) @local.definition.function)
    (exported_symbol
      (accent_quoted) @local.definition.function)
  ]
  (#set! "definition.function.scope" "parent"))

(converter_declaration
  name: [
    (identifier) @local.definition.function
    (accent_quoted) @local.definition.function
    (exported_symbol
      (identifier) @local.definition.function)
    (exported_symbol
      (accent_quoted) @local.definition.function)
  ]
  (#set! "definition.function.scope" "parent"))

; ==============================================================================
; @local.definition.method     ; methods
(method_declaration
  name: [
    (identifier) @local.definition.method
    (accent_quoted) @local.definition.method
    (exported_symbol
      (identifier) @local.definition.method)
    (exported_symbol
      (accent_quoted) @local.definition.method)
  ]
  (#set! "definition.method.scope" "parent"))

; ==============================================================================
; @local.definition.var        ; variables
(var_section
  (variable_declaration
    (symbol_declaration_list
      (symbol_declaration
        name: [
          (identifier) @local.definition.var
          (accent_quoted) @local.definition.var
          (exported_symbol
            (identifier) @local.definition.var)
          (exported_symbol
            (accent_quoted) @local.definition.var)
        ]))
    type: (type_expression)? @local.definition.associated))

(let_section
  (variable_declaration
    (symbol_declaration_list
      (symbol_declaration
        name: [
          (identifier) @local.definition.var
          (accent_quoted) @local.definition.var
          (exported_symbol
            (identifier) @local.definition.var)
          (exported_symbol
            (accent_quoted) @local.definition.var)
        ]))
    type: (type_expression)? @local.definition.associated))

(for
  (symbol_declaration_list
    (symbol_declaration
      name: [
        (identifier) @local.definition.var
        (accent_quoted) @local.definition.var
      ])))

(try
  (except_branch
    values: (expression_list
      (infix_expression
        right: [
          (identifier) @local.definition.var
          (accent_quoted) @local.definition.var
        ]))))

; ==============================================================================
; @local.definition.parameter  ; parameters
(parameter_declaration
  (symbol_declaration_list
    (symbol_declaration
      name: [
        (identifier) @local.definition.parameter
        (accent_quoted) @local.definition.parameter
      ]))
  type: (type_expression)? @local.definition.associated)

(concept_declaration
  parameters: (parameter_list
    [
      (identifier) @local.definition.parameter
      (accent_quoted
        (identifier) @local.definition.parameter)
    ]))

(var_parameter
  [
    (identifier) @local.definition.parameter
    (accent_quoted
      (identifier) @local.definition.parameter)
  ])

(type_parameter
  [
    (identifier) @local.definition.parameter
    (accent_quoted
      (identifier) @local.definition.parameter)
  ])

(static_parameter
  [
    (identifier) @local.definition.parameter
    (accent_quoted
      (identifier) @local.definition.parameter)
  ])

(ref_parameter
  [
    (identifier) @local.definition.parameter
    (accent_quoted
      (identifier) @local.definition.parameter)
  ])

(pointer_parameter
  [
    (identifier) @local.definition.parameter
    (accent_quoted
      (identifier) @local.definition.parameter)
  ])

; ==============================================================================
; @local.definition.macro      ; preprocessor macros
(template_declaration
  name: [
    (identifier) @local.definition.macro
    (accent_quoted) @local.definition.macro
    (exported_symbol
      (identifier) @local.definition.macro)
    (exported_symbol
      (accent_quoted) @local.definition.macro)
  ]
  (#set! "definition.macro.scope" "parent"))

(macro_declaration
  name: [
    (identifier) @local.definition.macro
    (accent_quoted) @local.definition.macro
    (exported_symbol
      (identifier) @local.definition.macro)
    (exported_symbol
      (accent_quoted) @local.definition.macro)
  ]
  (#set! "definition.macro.scope" "parent"))

; ==============================================================================
; @local.definition.type       ; types or classes
(type_declaration
  (type_symbol_declaration
    name: [
      (identifier) @local.definition.type
      (accent_quoted) @local.definition.type
      (exported_symbol
        (identifier) @local.definition.type)
      (exported_symbol
        (accent_quoted) @local.definition.type)
    ]))

; ==============================================================================
; @local.definition.field      ; fields or properties
; object_declaration
; variant_declaration
; conditional_declaration
; tuple_type inline
; tuple_type multiline
(field_declaration
  (symbol_declaration_list
    (symbol_declaration
      name: [
        (identifier) @local.definition.field
        (accent_quoted) @local.definition.field
        (exported_symbol
          (identifier) @local.definition.field)
        (exported_symbol
          (accent_quoted) @local.definition.field)
      ]))
  type: (type_expression)? @local.definition.associated)

; ==============================================================================
; @local.definition.enum       ; enumerations
(enum_declaration
  (enum_field_declaration
    (symbol_declaration
      name: [
        (identifier) @local.definition.enum
        (accent_quoted) @local.definition.enum
      ])))

; ==============================================================================
; @local.definition.namespace  ; modules or namespaces
; @local.definition.import     ; imported names
(import_statement
  (expression_list
    (identifier) @local.definition.namespace))

(import_statement
  (expression_list
    (infix_expression
      operator: "as"
      right: (identifier) @local.definition.namespace)))

(import_statement
  (expression_list
    (infix_expression
      operator: (operator) @_operator
      right: [
        (identifier) @local.definition.namespace
        (array_construction
          (identifier) @local.definition.namespace)
      ]))
  (#eq? @_operator "/"))

(import_from_statement
  module: (infix_expression
    operator: (operator) @_operator
    right: (identifier) @local.definition.namespace)
  (expression_list
    [
      (identifier) @local.definition.import
      (accent_quoted) @local.definition.import
    ])
  (#eq? @_operator "/"))

; ==============================================================================
; @local.scope                 ; scope block
; (when)
; NOTE: `when` does actually not create a scope
(if
  consequence: (statement_list) @local.scope
  alternative: (elif_branch)* @local.scope
  alternative: (else_branch)? @local.scope)

(case
  alternative: (of_branch)* @local.scope
  alternative: (elif_branch)* @local.scope
  alternative: (else_branch)? @local.scope)

(try
  body: (statement_list) @local.scope
  (except_branch) @local.scope
  (finally_branch)? @local.scope)

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
] @local.scope

; ==============================================================================
; @local.reference             ; identifier reference
(identifier) @local.reference

(accent_quoted) @local.reference
