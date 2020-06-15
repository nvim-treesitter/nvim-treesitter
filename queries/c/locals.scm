;; Functions definitions
(function_declarator
  declarator: (identifier) @definition.function)
(preproc_function_def
  name: (identifier) @definition.macro) @scope

(preproc_def
  name: (identifier) @definition.macro)
(pointer_declarator
  declarator: (identifier) @definition.var)
(parameter_declaration
  declarator: (identifier) @definition.var)
(init_declarator
  declarator: (identifier) @definition.var)
(array_declarator
  declarator: (identifier) @definition.var)
(declaration
  declarator: (identifier) @definition.var)
(enum_specifier
  name: (_) @definition.type
  (enumerator_list
    (enumerator name: (identifier) @definition.var)))

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
(translation_unit) @scope
(function_definition) @scope
(compound_statement) @scope ; a block in curly braces
