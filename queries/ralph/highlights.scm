(type_identifier) @type
(primitive_type) @type.builtin
(alph_token_id) @type.builtin

(var_declaration) @variable
(struct_field) @variable
(arg_def (identifier) @variable)
(struct_constructor_field (identifier) @variable)

(hex_num) @number
(integer) @number
(typed_num) @number

(bool)  @constant.builtin
(bytes) @constant.builtin
(address) @constant.builtin

(func_id) @function

(mutable) @keyword
(annotation)  @keyword
(annotation (identifier) @keyword)
(annotation_field (identifier) @variable)
(annotation_field (identifier) @variable)
(map_def (identifier) @variable)

"Abstract" @keyword
"Contract" @keyword
"TxScript" @keyword
"Interface" @keyword
"AssetScript" @keyword
"struct" @keyword
"fn" @keyword
"pub" @keyword
"let" @keyword
"while" @keyword
"for" @keyword
"if" @keyword
"else" @keyword
"emit" @keyword
"enum" @keyword
"extends" @keyword
"embeds" @keyword
"implements" @keyword
"return" @keyword
"const" @keyword
"event" @keyword
"mapping" @keyword

"(" @punctuation.bracket
")" @punctuation.bracket
"[" @punctuation.bracket
"]" @punctuation.bracket
"{" @punctuation.bracket
"}" @punctuation.bracket

"." @punctuation.delimiter
"," @punctuation.delimiter
":" @punctuation.delimiter
";" @punctuation.delimiter
"=" @punctuation.delimiter
"->" @punctuation.delimiter

(op_byte_vec_add) @operator
(op_add) @operator
(op_sub) @operator
(op_mul) @operator
(op_exp) @operator
(op_mod_exp) @operator
(op_div) @operator
(op_mod) @operator
(op_mod_add) @operator
(op_mod_sub) @operator
(op_mod_mul) @operator
(op_shl) @operator
(op_shr) @operator
(op_bit_and) @operator
(op_xor) @operator
(op_bit_or) @operator
(op_eq) @operator
(op_ne) @operator
(op_lt) @operator
(op_le) @operator
(op_gt) @operator
(op_ge) @operator
(op_and) @operator
(op_or) @operator
(op_not) @operator

(line_comment) @comment

