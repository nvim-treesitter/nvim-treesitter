[
  (compound_stmt)
  (initializer_list)
  (implies_body)
  (struct_body)
  (bitstruct_body)
  (enum_body)
  (interface_body)
  (switch_body)
  (ct_if_stmt)
  (ct_for_stmt)
  (ct_foreach_stmt)
  (ct_switch_stmt)
] @indent.begin

([
  (case_stmt)
  (default_stmt)
  (ct_case_stmt)
] @indent.begin
  (#set! indent.immediate 1))

(expr_stmt
  ";" @indent.end) @indent.begin

(declaration
  ";" @indent.end) @indent.begin

(const_declaration
  ";" @indent.end) @indent.begin

(return_stmt
  ";" @indent.end) @indent.begin

(faultdef_declaration
  ";" @indent.end) @indent.begin

(macro_func_body
  ";" @indent.end)

[
  ")"
  "}"
  "$endfor"
  "$endforeach"
  "$endswitch"
  "$endif"
] @indent.branch @indent.end

"$else" @indent.branch

([
  (func_param_list)
  (macro_param_list)
  (enum_param_list)
  (attribute_param_list)
  (call_arg_list)
  (paren_cond)
  (for_cond)
  (foreach_cond)
  (paren_expr)
] @indent.align
  (#set! indent.open_delimiter "(")
  (#set! indent.close_delimiter ")"))

[
  (block_comment)
  (doc_comment)
  (raw_string_literal)
  (bytes_literal)
] @indent.auto

(string_literal) @indent.ignore
