(type_identifier) @type

(identifier) @variable

[
  (primitive_type)
  (alph_token_id)
] @type.builtin

(var_declaration) @variable

(struct_field
  (identifier) @variable.member)

(arg_def
  (identifier) @variable.parameter)

(event_field
  (identifier) @variable.parameter)

(struct_constructor_field
  (identifier) @variable.parameter)

[
  (hex_num)
  (integer)
  (typed_num)
] @number

[
  (bool)
  (bytes)
  (address)
] @constant.builtin

(func_id
  [
    (identifier)
    "!"
  ] @function)

(annotation
  [
    "@"
    (identifier)
  ] @attribute)

(map_def
  (identifier) @variable.parameter)

"fn" @keyword.function

[
  "Contract"
  "TxScript"
  "Interface"
  "AssetScript"
  "struct"
  "enum"
  "event"
  "mapping"
] @keyword.type

[
  "pub"
  "Abstract"
  (mutable)
] @keyword.modifier

[
  "while"
  "for"
] @keyword.repeat

"return" @keyword.return

[
  "if"
  "else"
] @keyword.conditional

[
  "const"
  "let"
  "emit"
  "extends"
  "embeds"
  "implements"
] @keyword

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

[
  "."
  ","
  ":"
  ";"
] @punctuation.delimiter

[
  "="
  "->"
  (op_byte_vec_add)
  (op_add)
  (op_sub)
  (op_mul)
  (op_exp)
  (op_mod_exp)
  (op_div)
  (op_mod)
  (op_mod_add)
  (op_mod_sub)
  (op_mod_mul)
  (op_shl)
  (op_shr)
  (op_bit_and)
  (op_xor)
  (op_bit_or)
  (op_eq)
  (op_ne)
  (op_lt)
  (op_le)
  (op_gt)
  (op_ge)
  (op_and)
  (op_or)
  (op_not)
] @operator

(line_comment) @comment @spell
