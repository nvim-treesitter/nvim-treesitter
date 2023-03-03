[
  (typeDef)
  (ifStmt)
  (whenStmt)
  (elifStmt)
  (elseStmt)
  (ofBranch) ; note: not caseStmt
  (whileStmt)
  (tryStmt)
  (tryExceptStmt)
  (tryFinallyStmt)
  (forStmt)
  (blockStmt)
  (staticStmt)
  (deferStmt)
  (asmStmt)
  ; exprStmt?
] @indent
;; increase the indentation level

[
  (returnStmt)
  (raiseStmt)
  (yieldStmt)
  (breakStmt)
  (continueStmt)
] @indent_end
;; end a level of indentation while staying indented

[
  ")" ; tuples
  "]" ; arrays, seqs
  "}" ; sets
] @branch
;; end a level of indentation and unindent the line
