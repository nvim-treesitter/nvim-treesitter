(defun_header
  function_name: (sym_lit) @local.definition.function
  (#set! definition.function.scope "parent"))

(defun_header
  lambda_list:
    (list_lit
      (sym_lit) @local.definition.parameter))

(defun_header
  keyword:
    (defun_keyword
      "defmethod")
  lambda_list:
    (list_lit
      (list_lit
        .
        (sym_lit)
        .
        (sym_lit) @local.definition.type)))

(defun_header
  lambda_list:
    (list_lit
      (list_lit
        .
        (sym_lit) @local.definition.parameter
        .
        (_))))

(sym_lit) @local.reference

(defun) @local.scope

((list_lit
  .
  (sym_lit) @_defvar
  .
  (sym_lit) @local.definition.var)
  (#match? @_defvar "^(cl:)?(defvar|defparameter)$"))

(list_lit
  .
  (sym_lit) @_deftest
  .
  (sym_lit) @local.definition.function
  (#eq? @_deftest "deftest")) @local.scope

(list_lit
  .
  (sym_lit) @_deftest
  .
  (sym_lit) @local.definition.function
  (#eq? @_deftest "deftest")) @local.scope

(for_clause
  .
  (sym_lit) @local.definition.var)

(with_clause
  .
  (sym_lit) @local.definition.var)

(loop_macro) @local.scope

(list_lit
  .
  (sym_lit) @_let
  (#match? @_let "(cl:|cffi:)?(with-accessors|with-foreign-objects|let[*]?)")
  .
  (list_lit
    (list_lit
      .
      (sym_lit) @local.definition.var))) @local.scope

(list_lit
  .
  (sym_lit) @_let
  (#match? @_let "(cl:|alexandria:)?(with-gensyms|dotimes|with-foreign-object)")
  .
  (list_lit
    .
    (sym_lit) @local.definition.var)) @local.scope

(list_lit
  .
  (kwd_lit) @_import_from
  (#eq? @_import_from ":import-from")
  .
  (_)
  (kwd_lit
    (kwd_symbol) @local.definition.import))

(list_lit
  .
  (kwd_lit) @_import_from
  (#eq? @_import_from ":import-from")
  .
  (_)
  (sym_lit) @local.definition.import)

(list_lit
  .
  (kwd_lit) @_use
  (#eq? @_use ":use")
  (kwd_lit
    (kwd_symbol) @local.definition.import))

(list_lit
  .
  (kwd_lit) @_use
  (#eq? @_use ":use")
  (sym_lit) @local.definition.import)
