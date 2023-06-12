; declarations
(class_declaration) @local.scope

(method_declaration) @local.scope

(constructor_declaration) @local.scope

(enum_declaration) @local.scope

(enhanced_for_statement) @local.scope

; if/else
(if_statement) @local.scope

(if_statement
  consequence: (_) @local.scope) ; if body in case there are no braces

(if_statement
  alternative: (_) @local.scope) ; else body in case there are no braces

; try/catch
(try_statement) @local.scope ; covers try+catch, individual try and catch are covered by (block)

(catch_clause) @local.scope ; needed because `Exception` variable

; loops
(for_statement) @local.scope

(for_statement ; "for" body in case there are no braces
  body: (_) @local.scope)

(do_statement
  body: (_) @local.scope)

(while_statement
  body: (_) @local.scope)

; Functions
(constructor_declaration) @local.scope

(method_declaration) @local.scope

; definitions
(enum_declaration
  name: (identifier) @local.definition.enum)

(method_declaration
  name: (identifier) @local.definition.method)

(local_variable_declaration
  declarator: (variable_declarator
    name: (identifier) @local.definition.var))

(enhanced_for_statement
  name: (identifier) @local.definition.var)

(formal_parameter
  name: (identifier) @local.definition.parameter)

(catch_formal_parameter
  name: (identifier) @local.definition.parameter)

(field_declaration
  declarator: (variable_declarator
    name: (identifier) @local.definition.field))

; REFERENCES
(identifier) @local.reference

(type_identifier) @local.reference
