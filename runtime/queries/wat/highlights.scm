[
  (block_comment)
  (line_comment)
] @comment

((block_comment)+ @comment.documentation
  (#match? @comment.documentation "^;;;\\s+.*"))

[
  "block"
  "data"
  "declare"
  "elem"
  "end"
  "export"
  "field"
  "final"
  "global"
  "item"
  "local"
  "memory"
  "module"
  "null"
  "offset"
  "pagesize"
  "param"
  "rec"
  "ref"
  "result"
  "shared"
  "start"
  "sub"
  "table"
  "tag"
  "try_table"
  "unshared"
] @keyword

"func" @keyword.function

"import" @keyword.import

[
  "type"
  "struct"
  "array"
] @keyword.type

"mut" @keyword.modifier

"loop" @keyword.repeat

[
  "catch"
  "catch_ref"
  "catch_all"
  "catch_all_ref"
] @keyword.exception

[
  "if"
  "then"
  "else"
] @keyword.conditional

[
  (integer)
  (uinteger)
] @number

(float) @number.float

(instr_name) @operator

[
  "("
  ")"
] @punctuation.bracket

(annotation_start) @attribute

(string) @string

((annotation_elem) @string
  (#match? @string "^\".*\"$"))

[
  (num_type)
  (vec_type)
  (packed_type)
] @type.builtin

((ref_type) @type.builtin
  (#match? @type.builtin "^(any|eq|i31|struct|array|null|(null)?func|(null)?exn|(null)?extern)ref$"))

((heap_type) @type.builtin
  (#match? @type.builtin "^(any|eq|i31|struct|array|null|(null)?func|(null)?exn|(null)?extern)$"))

(identifier) @variable

(index
  (uinteger) @variable)

(param
  (identifier) @variable.parameter)

(field
  (identifier) @variable.member)

(module
  (identifier) @module)

([
  (block_block)
  (block_if)
  (block_loop)
  (block_try_table)
]
  (identifier) @label)

(module_field_func
  (identifier) @function)

(extern_type_func
  (identifier) @function)

(module_field_start
  (index
    [
      (identifier)
      (uinteger)
    ] @function.call))

(plain_instr
  ((instr_name) @operator
    (#match? @operator "^(return_)?call$"))
  [
    (identifier)
    (integer)
  ] @function.call)

(type_def
  (identifier) @type)
