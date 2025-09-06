; inherits: python

([
  (rule_definition)
  (checkpoint_definition)
  (rule_inheritance)
  (module_definition)
  (directive)
] @indent.begin
  (#set! indent.immediate 1))

((rule_import
  "with"
  ":") @indent.begin
  (#set! indent.immediate 1))

; ; end indentation after last parameter node (no following ',')
; ; accommodate different levels of nesting
; ; see also queries/python/indents.scm: return_statement
(directive
  (directive_parameters
    [
      (_) @indent.dedent
      (_
        [
          (_)
          ")"
          "}"
          "]"
        ] .) @indent.dedent
    ]
    . ; anchor at end: no subsequent ','
    ))
