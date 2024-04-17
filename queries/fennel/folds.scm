; compounds
[
  (list)
  (table)
  (sequence)
] @fold

; sub-forms / special compounds
[
  (list_binding)
  (table_binding)
  (sequence_binding)
  (table_metadata)
  (sequence_arguments)
  (let_vars)
  (case_guard_or_special)
  (case_guard)
  (case_catch)
] @fold

; forms
[
  (quote_form)
  (unquote_form)
  (local_form)
  (var_form)
  (set_form)
  (global_form)
  (let_form)
  (fn_form)
  (lambda_form)
  (hashfn_form)
  (each_form)
  (collect_form)
  (icollect_form)
  (accumulate_form)
  (for_form)
  (fcollect_form)
  (faccumulate_form)
  (case_form)
  (match_form)
  (case_try_form)
  (match_try_form)
] @fold

; reader macros
(quote_reader_macro
  expression: (_) @fold)

(quasi_quote_reader_macro
  expression: (_) @fold)
