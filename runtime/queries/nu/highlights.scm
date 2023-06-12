; ---
; keywords
[
  "let"
  "let-env"
  "mut"
  "const"
  "hide-env"
  "source"
  "source-env"
  "overlay"
] @keyword

[
  "if"
  "else"
  "match"
] @keyword.conditional

[
  "loop"
  "while"
  "break"
  "continue"
] @keyword.repeat

[
  "def"
  "do"
] @keyword.function

"return" @keyword.return

[
  "try"
  "catch"
  "error"
] @keyword.exception

[
  "module"
  "use"
] @keyword.import

[
  "alias"
  "export-env"
  "export"
  "extern"
] @keyword.modifier

(hide_mod
  "hide" @keyword)

(decl_use
  module: (unquoted) @module)

(ctrl_for
  "for" @keyword
  "in" @keyword)

(overlay_list
  "list" @keyword.import)

(overlay_hide
  "hide" @keyword.import)

(overlay_new
  "new" @keyword.import)

(overlay_use
  "as" @keyword)

(ctrl_error
  "make" @keyword.import)

; ---
; literals
(val_number) @number

(val_duration
  unit: _ @variable.parameter)

(val_filesize
  unit: _ @variable.parameter)

(val_binary
  [
    "0b"
    "0o"
    "0x"
  ] @number
  digit: [
    "," @punctuation.delimiter
    (hex_digit) @number
  ]) @number

(val_bool) @constant.builtin

(val_nothing) @constant.builtin

(val_string) @string

arg_str: (val_string) @variable.parameter

file_path: (val_string) @variable.parameter

(val_date) @number

(inter_escape_sequence) @string.escape

(escape_sequence) @string.escape

(val_interpolated
  [
    "$\""
    "$'"
    "\""
    "'"
  ] @string)

(unescaped_interpolated_content) @string

(escaped_interpolated_content) @string

(expr_interpolated
  [
    "("
    ")"
  ] @variable.parameter)

; ---
; operators
[
  "+"
  "-"
  "*"
  "/"
  "//"
  "++"
  "**"
  "=="
  "!="
  "<"
  "<="
  ">"
  ">="
  "=~"
  "!~"
  "="
  "+="
  "-="
  "*="
  "/="
  "++="
  "-"
  ".."
  "..="
  "..<"
  "=>"
  "="
  "|"
  "o>"
  "out>"
  "e>"
  "err>"
  "e+o>"
  "err+out>"
  "o+e>"
  "out+err>"
  "o>>"
  "out>>"
  "e>>"
  "err>>"
  "e+o>>"
  "err+out>>"
  "o+e>>"
  "out+err>>"
  "e>|"
  "err>|"
  "e+o>|"
  "err+out>|"
  "o+e>|"
  "out+err>|"
] @operator

[
  "mod"
  "and"
  "or"
  "xor"
  "bit-or"
  "bit-xor"
  "bit-and"
  "bit-shl"
  "bit-shr"
  "in"
  "not-in"
  "has"
  "not-has"
  "starts-with"
  "ends-with"
  "not"
] @keyword.operator

; ---
; punctuation
[
  ","
  ";"
  ":"
] @punctuation.delimiter

(param_long_flag
  "--" @punctuation.delimiter)

(long_flag
  "--" @punctuation.delimiter)

(long_flag
  "=" @punctuation.delimiter)

(short_flag
  "-" @punctuation.delimiter)

(short_flag
  "=" @punctuation.delimiter)

(param_short_flag
  "-" @punctuation.delimiter)

(param_rest
  "..." @punctuation.delimiter)

(param_value
  "=" @punctuation.delimiter)

(param_cmd
  "@" @punctuation.delimiter)

(param_opt
  "?" @punctuation.delimiter)

(returns
  "->" @punctuation.delimiter)

[
  "("
  ")"
  "{"
  "}"
  "["
  "]"
  "...["
  "...("
  "...{"
] @punctuation.bracket

(parameter_pipes
  "|" @punctuation.bracket)

key: (identifier) @property

; ---
; identifiers
(param_rest
  name: (_) @variable.parameter)

(param_opt
  name: (_) @variable.parameter)

(parameter
  param_name: (_) @variable.parameter)

(param_cmd
  (cmd_identifier) @string)

(attribute
  "@" @attribute)

[
  (attribute_identifier)
  (long_flag_identifier)
  (param_short_flag_identifier)
  (short_flag_identifier)
] @attribute

(scope_pattern
  (wild_card) @function)

(cmd_identifier) @function

; generated with Nu 0.93.0
; > help commands
;   | filter { $in.command_type == builtin and $in.category != core }
;   | each {$'"($in.name | split row " " | $in.0)"'}
;   | uniq
;   | str join ' '
(command
  head: [
    (cmd_identifier) @function.builtin
    (#any-of? @function.builtin
      "all" "ansi" "any" "append" "ast" "bits" "bytes" "cal" "cd" "char" "clear" "collect" "columns"
      "compact" "complete" "config" "cp" "date" "debug" "decode" "default" "detect" "dfr" "drop"
      "du" "each" "encode" "enumerate" "every" "exec" "exit" "explain" "explore" "export-env" "fill"
      "filter" "find" "first" "flatten" "fmt" "format" "from" "generate" "get" "glob" "grid" "group"
      "group-by" "hash" "headers" "histogram" "history" "http" "input" "insert" "inspect"
      "interleave" "into" "is-empty" "is-not-empty" "is-terminal" "items" "join" "keybindings"
      "kill" "last" "length" "let-env" "lines" "load-env" "ls" "math" "merge" "metadata" "mkdir"
      "mktemp" "move" "mv" "nu-check" "nu-highlight" "open" "panic" "par-each" "parse" "path"
      "plugin" "port" "prepend" "print" "ps" "query" "random" "range" "reduce" "reject" "rename"
      "reverse" "rm" "roll" "rotate" "run-external" "save" "schema" "select" "seq" "shuffle" "skip"
      "sleep" "sort" "sort-by" "split" "split-by" "start" "stor" "str" "sys" "table" "take" "tee"
      "term" "timeit" "to" "touch" "transpose" "tutor" "ulimit" "uname" "uniq" "uniq-by" "update"
      "upsert" "url" "values" "view" "watch" "where" "which" "whoami" "window" "with-env" "wrap"
      "zip")
  ])

(command
  "^" @punctuation.delimiter
  head: (_) @function)

"where" @function.builtin

(path
  [
    "."
    "?"
  ] @punctuation.delimiter) @variable.parameter

(stmt_let
  (identifier) @variable)

(val_variable
  "$"? @punctuation.special
  "...$"? @punctuation.special
  [
    (identifier) @variable
    "in" @variable.parameter.builtin
    "nu" @module
    "env" @constant
  ]) @none

; ---
; types
(flat_type) @type

(list_type
  "list" @type.builtin
  [
    "<"
    ">"
  ] @punctuation.bracket)

(collection_type
  [
    "record"
    "table"
  ] @type.builtin
  "<" @punctuation.bracket
  key: (_) @variable.parameter
  [
    ","
    ":"
  ] @punctuation.delimiter
  ">" @punctuation.bracket)

(shebang) @keyword.directive

(comment) @comment @spell

((comment)+ @comment.documentation @spell
  .
  (decl_def))

(parameter
  (comment) @comment.documentation @spell)
