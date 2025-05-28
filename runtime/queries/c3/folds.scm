[
  ; Top-level declarations
  (bitstruct_declaration)
  (enum_declaration)
  (faultdef_declaration)
  (func_definition)
  (import_declaration)+
  (interface_declaration)
  (macro_declaration)
  (struct_declaration)
  ; Statements
  (asm_block_stmt)
  (case_stmt)
  (defer_stmt)
  (do_stmt)
  (for_stmt)
  (foreach_stmt)
  (if_stmt)
  (switch_stmt)
  (while_stmt)
  (ct_for_stmt)
  (ct_foreach_stmt)
  (ct_switch_stmt)
  (ct_case_stmt)
  (ct_if_stmt)
  (ct_else_stmt)
  ; Comments
  (block_comment)
  (doc_comment)
  ; Initializer list
  (initializer_list)
] @fold

(compound_stmt
  (compound_stmt) @fold)
