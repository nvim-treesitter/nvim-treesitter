(identifier) @variable
((identifier) @constant
 (#match? @constant "^[A-Z][A-Z_0-9]*$"))

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
(function_declaration parameters: (parameters (identifier) @parameter))

[ (bang) (spread) ] @punctuation.special

[ (no_option) (inv_option) (default_option) (option_name) ] @variable.builtin
[
  (scope)
  "a:"
  "$"
] @namespace

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
  "highlight"
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

(hl_attribute
  key: _ @property
  val: _ @constant)

(hl_group) @variable
(augroup_name) @namespace

(au_event) @constant
(normal_statement (commands) @constant)

;; Literals

(string_literal) @string
(integer_literal) @number
(float_literal) @float
(comment) @comment
(pattern) @string.special
((scoped_identifier
  (scope) @_scope . (identifier) @boolean)
 (#eq? @_scope "v:")
 (#any-of? @boolean "true" "false"))

;; Operators

[
  "||"
  "&&"
  "&"
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

[
  ","
  ":"
] @punctuation.delimiter

(ternary_expression ["?" ":"] @conditional)

; Options
((set_value) @number
 (#match? @number "^[0-9]+(\.[0-9]+)?$"))
