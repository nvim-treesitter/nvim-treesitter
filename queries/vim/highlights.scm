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

[ (bang) (spread) ] @punctuation.special

[ (no_option) (inv_option) (default_option) (option_name) ] @variable.builtin
(scope) @namespace

;; Commands and user defined commands

[
  "let"
  "execute"
  "set"
  "silent"
  "echo"
  "autocmd"
  "return"
  "lua"
  "ruby"
  "perl"
  "python"
] @keyword
(command_name) @function.macro

(autocmd_statement (event) @constant)

;; Literals

(string_literal) @string
(integer_literal) @number
(float_literal) @float
(comment) @comment

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
  "."
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

;; Function related

(call_expression function: (identifier) @function)
