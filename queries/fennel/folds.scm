[
  (list)
  (table)
  (sequence)
] @fold

(list
  .
  (symbol) @_let
  (#eq? @_let "let")
  .
  (sequence) @fold) @fold

(list
  .
  (symbol) @_local
  (#eq? @_local "local")) @fold

(list
  .
  (symbol) @_global
  (#eq? @_global "global")) @fold

(list
  .
  (symbol) @_fn
  (#any-of? @_fn "fn" "lambda" "λ" "hashfn")) @fold

(reader_macro
  macro:
    [
      "'"
      "`"
    ]
  expression: (_) @fold)
