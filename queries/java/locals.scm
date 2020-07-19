; CREDITS @maxbrunsfeld (maxbrunsfeld@gmail.com)

;(class_declaration
;  name: (identifier) @name) @class
;
;(method_declaration
;  name: (identifier) @name) @method
;
;(method_invocation
;  name: (identifier) @name) @call

(class_declaration) @scope
(method_declaration) @scope
(if_statement) @scope
(for_statement) @scope
(try_statement
  body: (_) @scope)
(catch_clause) @scope

(class_declaration
  name: (identifier) @definition.type)
(method_declaration
  name: (identifier) @definition.method)
