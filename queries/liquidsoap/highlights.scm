(op) @operator
"..." @operator
["and" "or" "not"] @keyword.operator

[ "def"
  "fun"
  "let" ] @keyword.function 

[
  "open"
  "begin"
  "end"
] @keyword

[ "while"
  "do"
  "to"
  "for" ] @repeat

[ "if"
  "then"
  "elsif"
  "else" ] @conditional

[ "try"
  "catch" ] @exception

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
(integer) @number
(float) @number
(bool) @boolean
(comment) @comment
(regexp) @string.regex
(type) @type
