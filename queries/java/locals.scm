; SCOPES
(class_declaration
   body: (_) @scope)
(enum_declaration
   body: (_) @scope)
(method_declaration) @scope
(block) @scope
(if_statement) @scope
(if_statement
  consequence: (_) @scope)
(if_statement
  alternative: (_) @scope)
(try_statement) @scope
(catch_clause) @scope
(do_statement) @scope
(do_statement
  body: (_) @scope)
(while_statement) @scope
(while_statement
  body: (_) @scope)
(for_statement) @scope
(for_statement
  body: (_) @scope)

; DEFINITIONS
(class_declaration
  name: (identifier) @definition.class)
(enum_declaration
  name: (identifier) @definition.enum)
(method_declaration
  name: (identifier) @definition.method)
(local_variable_declaration
  declarator: (variable_declarator
                name: (identifier) @definition.var))
(field_declaration
  declarator: (variable_declarator
                name: (identifier) @definition.field))
(import_declaration) @definition.import

; REFERENCES
(identifier) @reference
(type_identifier) @reference
