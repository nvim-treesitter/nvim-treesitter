(program) @local.scope

(symbol) @local.reference

[
  (let_form)
  (fn_form)
  (lambda_form)
  (each_form)
  (for_form)
  (collect_form)
  (icollect_form)
  (accumulate_form)
  (for_form)
  (fcollect_form)
  (faccumulate_form)
  (case_form)
  (match_form)
] @local.scope

(list
  call: (symbol) @_call
  (#any-of? @_call "while" "if" "when" "do")) @local.scope

(fn_form
  name:
    [
      (symbol) @local.definition.function
      (multi_symbol
        member: (symbol_fragment) @local.definition.function .)
    ]
  args:
    (sequence_arguments
      (symbol_binding) @local.definition.parameter)
  (#set! definition.function.scope "parent"))

; NOTE: Body should be identical to fn_form above
(lambda_form
  name:
    [
      (symbol) @local.definition.function
      (multi_symbol
        member: (symbol_fragment) @local.definition.function .)
    ]
  args:
    (sequence_arguments
      (symbol_binding) @local.definition.parameter)
  (#set! definition.function.scope "parent"))
