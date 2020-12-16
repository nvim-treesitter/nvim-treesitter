(block_mapping_pair key: (flow_node) @field)
(flow_pair key: (flow_node) @field) ; This one doesn't seem to work, no idea what's wrong with it.
(boolean_scalar) @boolean
(null_scalar) @constant.builtin
(double_quote_scalar) @string
(single_quote_scalar) @string
(double_quote_scalar (escape_sequence)) @string.escape
(single_quote_scalar (escape_sequence)) @string.escape
(integer_scalar) @number
(float_scalar) @number
(comment) @comment
(anchor) @type
(alias) @type
(tag) @type
(yaml_directive) @keyword
(ERROR) @error
[
; "+" ; including this causes "invalid node type" errors?!?
","
"-"
":"
">"
"?"
"|"
] @punctuation.delimiter
[
"["
"]"
"{"
"}"
] @punctuation.bracket
