; CEL is a pure expression language — variables are provided by the evaluation
; environment rather than declared in the expression itself. We mark the root
; expression as a scope and all identifiers as references so that editors can
; apply local-variable highlighting and scope-aware navigation.
; Scopes
(expr) @local.scope

; References
(identifier) @local.reference
