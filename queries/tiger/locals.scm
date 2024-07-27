; See this issue [1] for support for "lazy scoping" which is somewhat needed
; for Tiger semantics (e.g: one can call a function before it has been defined
; top-to-bottom).
;
; [1]: https://github.com/tree-sitter/tree-sitter/issues/918
; Scopes {{{
[
  (for_expression)
  (let_expression)
  (function_declaration)
] @local.scope

; }}}
; Definitions {{{
(type_declaration
  name: (identifier) @local.definition.type
  (#set! definition.var.scope "parent"))

(parameters
  name: (identifier) @local.definition.parameter)

(function_declaration
  name: (identifier) @local.definition.function
  (#set! definition.var.scope "parent"))

(primitive_declaration
  name: (identifier) @local.definition.function
  (#set! definition.var.scope "parent"))

(variable_declaration
  name: (identifier) @local.definition.var
  (#set! definition.var.scope "parent"))

; }}}
; References {{{
(identifier) @local.reference

; }}}
; vim: sw=2 foldmethod=marker
