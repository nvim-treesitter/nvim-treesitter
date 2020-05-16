;; Functions definitions
(function_declarator
  declarator: (identifier) @definition.function) @scope
(preproc_function_def
  name: (identifier) @definition.macro) @scope

(preproc_def
  name: (identifier) @definition.macro)
(pointer_declarator
  declarator: (identifier) @definition.variable)
(parameter_declaration
  declarator: (identifier) @definition.variable)
(init_declarator
  declarator: (identifier) @definition.variable)
(array_declarator
  declarator: (identifier) @definition.variable)
(declaration
  declarator: (identifier) @definition.variable)
(enum_specifier
  name: (*) @definition.type
  (enumerator_list
    (enumerator name: (identifier) @definition.variable)))

;; Type / Struct / Enum
(field_declaration
  declarator: (field_identifier) @definition.field)
(type_definition
  declarator: (type_identifier) @definition.type)

;; References
(identifier) @reference

;; Scope
(for_statement) @scope
(if_statement) @scope
(while_statement) @scope
