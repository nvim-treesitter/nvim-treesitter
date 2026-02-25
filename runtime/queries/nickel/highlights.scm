(comment) @comment @spell

(annot_atom
  doc: (static_string) @spell)

[
  "forall"
  "in"
  "let"
  "default"
  "doc"
  "rec"
  "optional"
  "priority"
  "force"
  "not_exported"
] @keyword

"fun" @keyword.function

"import" @keyword.import

[
  "if"
  "then"
  "else"
] @keyword.conditional

"match" @keyword.conditional

(types) @type

"Array" @type.builtin

; BUILTIN Constants
(bool) @boolean

"null" @constant.builtin

(enum_tag) @constant

(num_literal) @number

[
  (infix_op)
  "|>"
  "="
  "&"
  "=="
  "/"
  "!="
  "<"
  ">"
  "@"
  ".."
] @operator

(type_atom) @type

(static_string) @string

(chunk_literal_single) @string

(chunk_literal_multi) @string

(str_esc_char) @string.escape

[
  "{"
  "}"
  "("
  ")"
  "[|"
  "|]"
  "["
  "]"
] @punctuation.bracket

[
  ","
  "."
  ":"
  "|"
  "->"
  "+"
  "-"
  "*"
] @punctuation.delimiter

(multstr_start) @string

(multstr_end) @string

(interpolation_start) @punctuation.bracket

(interpolation_end) @punctuation.bracket

(builtin) @function.builtin

(fun_expr
  pats: (pattern_fun
    (ident) @variable.parameter))

; application where the head terms is an identifier: function arg1 arg2 arg3
(applicative
  t1: (applicative
    .
    (record_operand
      (atom
        (ident))) @function))

; application where the head terms is a record field path: foo.bar.function arg1 arg2 arg3
(applicative
  t1: (applicative
    .
    (record_operand
      (record_operation_chain)) @function))

(str_chunks) @string

(field_path_elem) @property

(infix_expr
  op: (infix_b_op_6)
  t2: (infix_expr
    (applicative
      .
      (record_operand
        (record_operation_chain) @function))))
