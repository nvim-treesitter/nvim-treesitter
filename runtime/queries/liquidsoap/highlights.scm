(var) @variable

(op) @operator
["and" "or" "not"] @keyword.operator

[
  "def"
  "fun"
  "def_end"
] @keyword.function

(let_decoration) @keyword.coroutine

[
  "open"
  "begin"
  "block_end"
  "let"
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

(string) @string
(string_interpolation [ "#{" "}" ] @punctuation.special)
(integer) @number
(float) @float
(bool) @boolean
(comment) @comment
(regexp) @string.regex
(type) @type
