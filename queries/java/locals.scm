; CREDITS @maxbrunsfeld (maxbrunsfeld@gmail.com)

;(class_declaration
;  name: (identifier) @name) @class
;
;(method_declaration
;  name: (identifier) @name) @method
;
;(method_invocation
;  name: (identifier) @name) @call

; SCOPES
(class_declaration) @scope
(method_declaration) @scope
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
  name: (identifier) @definition.type)
(method_declaration
  name: (identifier) @definition.method)
