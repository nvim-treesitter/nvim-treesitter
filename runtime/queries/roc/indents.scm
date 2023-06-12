; (value_declaration(expr_body(anon_fun_expr)))@indent.ignore
[
  (when_is_expr)
  (when_is_branch)
  (record_expr)
  (anon_fun_expr)
  (list_expr)
  (parenthesized_expr)
  (function_call_pnc_expr)
  (tuple_expr)
  "import"
  (exposes)
  (exposes_list)
  (exposing)
  ;patterns
  (record_pattern)
  (tuple_pattern)
  (list_pattern)
  ;ability stuff
  (ability_implementation)
  (opaque_type_def)
  ;types
  (record_type)
  (tags_type)
  (record_expr)
  (implements_implementation)
  "{"
  "("
  "["
] @indent.begin

;  ((record_type)
;   @indent.align
;   (#set! indent.open_delimiter "{")
;   (#set! indent.close_delimiter "}"))
;  ((record_expr)
;   @indent.align
;   (#set! indent.open_delimiter "{")
;   (#set! indent.close_delimiter "}"))
; ((tags_type) @indent.align
;   (#set! indent.open_delimiter "[")
;   (#set! indent.close_delimiter "]"))
; ((implements_implementation) @indent.align
;   (#set! indent.open_delimiter "[")
;   (#set! indent.close_delimiter "]"))
(expr_body) @indent.begin

(ERROR
  "=") @indent.begin

(then) @indent.begin

(else) @indent.begin

[
  ; result:(_)
  "]"
  "}"
  ")"
] @indent.branch
