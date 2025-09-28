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
  (fcollect_form)
  (faccumulate_form)
  (case_form)
  (match_form)
  (case_try_form)
  (match_try_form)
  (if_form)
] @local.scope

(list
  call: (symbol) @_call
  (#any-of? @_call "while" "when" "do")) @local.scope

(fn_form
  name: [
    (symbol) @local.definition.function
    (multi_symbol
      member: (symbol_fragment) @local.definition.function .)
  ]
  args: (sequence_arguments
    (symbol_binding) @local.definition.parameter)
  (#set! definition.function.scope "parent"))

(lambda_form
  name: [
    (symbol) @local.definition.function
    (multi_symbol
      member: (symbol_fragment) @local.definition.function .)
  ]
  args: (sequence_arguments
    (symbol_binding) @local.definition.parameter)
  (#set! definition.function.scope "parent"))

(macro_form
  name: [
    (symbol) @local.definition.function
    (multi_symbol
      member: (symbol_fragment) @local.definition.function .)
  ]
  args: (sequence_arguments
    (symbol_binding) @local.definition.parameter)
  (#set! definition.function.scope "parent"))
