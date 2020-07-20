; SCOPES
(class_declaration
   body: (_) @scope)
(method_declaration) @scope
(block) @scope
; 3 captures for `if` - if+else, if only, else only
(if_statement) @scope
(if_statement
  body: (_)) @scope
(if_statement
  alternative: (_)) @scope
; 3 captures for`try` - try+catch, try only, catch only
(try_statement) @scope
(try_statement
  body: (_) @scope)
(catch_clause) @scope

(for_statement) @scope
(do_statement) @scope
(while_statement) @scope

; DEFINITIONS
(class_declaration
  name: (identifier) @definition.class)
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
