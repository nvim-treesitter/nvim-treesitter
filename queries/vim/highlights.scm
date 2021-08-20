;; Keywords

[
  "if"
  "else"
  "elseif"
  "endif"
] @conditional

[
  "try"
  "catch"
  "finally"
  "endtry"
  "throw"
] @exception

[
  "for"
  "endfor"
  "in"
  "while"
  "endwhile"
] @repeat

[
  "function"
  "endfunction"
] @keyword.function

;; Function related
(function_declaration name: (_) @function)
(call_expression function: (identifier) @function)

[ (bang) (spread) ] @punctuation.special

[ (no_option) (inv_option) (default_option) (option_name) ] @variable.builtin
[ (scope) "a:" ] @namespace

(ternary_expression ["?" ":"] @conditional)

;; Commands and user defined commands

[
  "let"
  "unlet"
  "call"
  "execute"
  "normal"
  "set"
  "silent"
  "echo"
  "autocmd"
  "augroup"
  "return"
  "lua"
  "ruby"
  "perl"
  "python"
] @keyword
(map_statement cmd: _ @keyword)
(command_name) @function.macro

[
  "<buffer>"
  "<nowait>"
  "<silent>"
  "<script>"
  "<expr>"
  "<unique>"
] @constant.builtin

[
  (augroup_name)
  (au_event)
] @constant
(normal_statement (commands) @constant)

;; Literals

(string_literal) @string
(integer_literal) @number
(float_literal) @float
(comment) @comment
(pattern) @string.special

;; Operators

[
  "||"
  "&&"
  "+"
  "-"
  "*"
  "/"
  "%"
  ".."
  "is"
  "isnot"
  "=="
  "!="
  ">"
  ">="
  "<"
  "<="
  "=~"
  "!~"
  "="
  "+="
  "-="
  "*="
  "/="
  "%="
  ".="
] @operator

; Some characters have different meanings based on the context
(unary_operation "!" @operator)
(binary_operation "." @operator)

;; Punctuation

[
  "("
  ")"
  "{"
  "}"
  "["
  "]"
] @punctuation.bracket

(field_expression "." @punctuation.delimiter)
"," @punctuation.delimiter
