(op) @operator
"..." @operator
["and" "or" "not"] @keyword.operator

[
  "def"
  "fun"
  "let"
  "def_end"
] @keyword.function

[
  "open"
  "begin"
  "block_end"
] @keyword

[
  "while"
  "do"
  "to"
  "for"
  "for_end"
  "while_end"
] @repeat

[
  "if"
  "then"
  "elsif"
  "else"
  "if_end"
] @conditional

[
  "try"
  "catch"
  "try_end"
] @exception

(inline_if [ "?" ":" ] @conditional.ternary)

[
  "%ifdef"
  "%ifndef"
  "%ifencoder"
  "%ifnencoder"
  "%ifversion"
  "%else"
  "%endif"
  "%argsof"
  "%include"
] @preproc

(encoder_name) @constant.builtin

(anonymous_argument (var) @parameter)
(labeled_argument label: (var) @parameter)

"." @punctuation.delimiter

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
]  @punctuation.bracket

(app name: (var) @function.call)
(method) @method
(method_app) @method.call

(var) @variable
(string) @string
(string_interpolation [ "#{" "}" ] @punctuation.special)
(integer) @number
(float) @float
(bool) @boolean
(comment) @comment
(regexp) @string.regex
(type) @type
