; Forked from https://github.com/nushell/tree-sitter-nu
; Copyright (c) 2019 - 2022 The Nushell Project Developers
; Licensed under the MIT license.
[
  (ctrl_match)
  (expr_parenthesized)
  (parameter_bracks)
  (val_record)
  (val_list)
  (val_closure)
  (val_table)
  (block)
] @indent.begin

[
  "}"
  "]"
  ")"
] @indent.end

[
  "}"
  "]"
  ")"
] @indent.branch

(comment) @indent.auto
