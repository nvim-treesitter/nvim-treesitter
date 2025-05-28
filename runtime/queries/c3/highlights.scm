; Punctuation
[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
  "[<"
  ">]"
] @punctuation.bracket

[
  ";"
  ","
  ":"
  "::"
] @punctuation.delimiter

; Constant
(const_ident) @constant

[
  "true"
  "false"
] @boolean

"null" @constant.builtin

; Variable
[
  (ident)
  (ct_ident)
  (hash_ident)
] @variable

; 1) Member
(field_expr
  field: (access_ident
    (ident) @variable.member))

(struct_member_declaration
  (ident) @variable.member)

(struct_member_declaration
  (identifier_list
    (ident) @variable.member))

(bitstruct_member_declaration
  (ident) @variable.member)

(initializer_list
  (initializer_element
    (param_path
      (param_path_element
        (access_ident
          (ident) @variable.member)))))

; 2) Parameter
(param
  name: (_) @variable.parameter)

(trailing_block_param
  (at_ident) @variable.parameter)

(call_arg_list
  (call_arg
    name: (_) @variable.parameter))

(enum_param
  (ident) @variable.parameter)

; Keyword (from `c3c --list-keywords`)
[
  "alias"
  "asm"
  "attrdef"
  "catch"
  "defer"
  "try"
  "var"
] @keyword

[
  "$alignof"
  "$assert"
  "$assignable"
  "$case"
  "$default"
  "$defined"
  "$echo"
  "$else"
  "$embed"
  "$endfor"
  "$endforeach"
  "$endif"
  "$endswitch"
  "$eval"
  "$evaltype"
  "$error"
  "$exec"
  "$extnameof"
  "$feature"
  "$for"
  "$foreach"
  "$if"
  "$include"
  "$is_const"
  "$nameof"
  "$offsetof"
  "$qnameof"
  "$sizeof"
  "$stringify"
  "$switch"
  "$typefrom"
  "$typeof"
  "$vacount"
  "$vatype"
  "$vaconst"
  "$vaarg"
  "$vaexpr"
  "$vasplat"
] @keyword.directive

"assert" @keyword.debug

"fn" @keyword.function

"macro" @keyword.function

"return" @keyword.return

[
  "import"
  "module"
] @keyword.import

[
  "bitstruct"
  "enum"
  "faultdef"
  "interface"
  "struct"
  "typedef"
  "union"
] @keyword.type

[
  "case"
  "default"
  "else"
  "if"
  "nextcase"
  "switch"
] @keyword.conditional

[
  "break"
  "continue"
  "do"
  "for"
  "foreach"
  "foreach_r"
  "while"
] @keyword.repeat

[
  "const"
  "extern"
  "inline"
  "static"
  "tlocal"
] @keyword.modifier

; Operator (from `c3c --list-operators`)
[
  "&"
  "!"
  "~"
  "|"
  "^"
  "="
  ">"
  "/"
  "."
  "<"
  "-"
  "%"
  "+"
  "?"
  "*"
  "&&"
  "!!"
  "&="
  "|="
  "^="
  "/="
  ".."
  "?:"
  "=="
  ">="
  "=>"
  "<="
  "-="
  "--"
  "%="
  "*="
  "!="
  "||"
  "+="
  "++"
  "??"
  "<<"
  ">>"
  "..."
  "<<="
  ">>="
  "&&&"
  "+++"
  "|||"
] @operator

(range_expr
  ":" @operator)

(foreach_cond
  ":" @operator)

(ct_foreach_cond
  ":" @operator)

(ternary_expr
  [
    "?"
    ":"
  ] @keyword.conditional.ternary)

(elvis_orelse_expr
  [
    "?:"
    "??"
  ] @keyword.conditional.ternary)

; Literal
(integer_literal) @number

(real_literal) @number.float

(char_literal) @character

(bytes_literal) @number

; String
(string_literal) @string

(raw_string_literal) @string

; Escape Sequence
(escape_sequence) @string.escape

; Builtin (constants)
(builtin_const) @constant.builtin

; Type Property (from `c3c --list-type-properties`)
(type_access_expr
  (access_ident
    (ident) @variable.builtin
    (#any-of? @variable.builtin
      "alignof" "associated" "elements" "extnameof" "from_ordinal" "get" "inf" "is_eq" "is_ordered"
      "is_substruct" "len" "lookup" "lookup_field" "max" "membersof" "methodsof" "min" "nan" "inner"
      "kindof" "names" "nameof" "params" "paramsof" "parentof" "qnameof" "returns" "sizeof" "tagof"
      "has_tagof" "values" "typeid")))

; Label
[
  (label)
  (label_target)
] @label

; Module
(module_resolution
  (ident) @module)

(module_declaration
  (path_ident
    (ident) @module))

(import_declaration
  (path_ident
    (ident) @module))

; Attribute
(attribute
  name: (at_ident) @attribute)

(at_type_ident) @attribute

(call_inline_attributes
  (at_ident) @attribute)

(asm_block_stmt
  (at_ident) @attribute)

; Type
[
  (type_ident)
  (ct_type_ident)
] @type

(base_type_name) @type.builtin

; Function Definition
(func_header
  name: (_) @function)

(func_header
  method_type: (_)
  name: (_) @function.method)

(macro_header
  name: (_) @function)

(macro_header
  method_type: (_)
  name: (_) @function.method)

; Function Call
(call_expr
  function: (ident_expr
    [
      (ident)
      (at_ident)
    ] @function.call))

(call_expr
  function: (trailing_generic_expr
    argument: (ident_expr
      [
        (ident)
        (at_ident)
      ] @function.call)))

; Method call
(call_expr
  function: (field_expr
    field: (access_ident
      [
        (ident)
        (at_ident)
      ] @function.method.call)))

; Method on type
(call_expr
  function: (type_access_expr
    field: (access_ident
      [
        (ident)
        (at_ident)
      ] @function.method.call)))

; Builtin call
(call_expr
  function: (builtin) @function.builtin)

; Asm
(asm_instr
  [
    (ident)
    "int"
  ] @function.builtin)

(asm_expr
  [
    (ct_ident)
    (ct_const_ident)
  ] @variable.builtin)

; Comment
[
  (line_comment)
  (block_comment)
] @comment @spell

(doc_comment) @comment.documentation

(doc_comment_text) @spell

(doc_comment_contract
  name: (_) @attribute)

(doc_comment_contract
  parameter: [
    (ident)
    (ct_ident)
    (hash_ident)
  ] @variable.parameter
  (#set! priority 110))

(doc_comment_contract
  [
    ":"
    "?"
  ] @comment.documentation
  (#set! priority 110))

(doc_comment_contract
  description: (_) @comment.documentation
  (#set! priority 110))
