; SCOPES
; declarations
(class_declaration
  body: (_) @scope)
(enum_declaration
  body: (_) @scope)
(method_declaration) @scope ; whole method_declaration because arguments

; block
(block) @scope

; if/else
(if_statement) @scope ; if+else
(if_statement
  consequence: (_) @scope) ; if body in case there are no braces
(if_statement
  alternative: (_) @scope) ; else body in case there are no braces

; try/catch
(try_statement) @scope ; covers try+catch, individual try and catch are covered by (block)

; loops
(for_statement) @scope ; whole for_statement because loop iterator variable
(for_statement         ; "for" body in case there are no braces
  body: (_) @scope)
(do_statement
  body: (_) @scope)
(while_statement
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
