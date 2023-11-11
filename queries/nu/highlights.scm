;;; ---
;;; keywords
[
    "def"
    "def-env"
    "alias"
    "export-env"
    "export"
    "extern"
    "module"

    "let"
    "let-env"
    "mut"
    "const"

    "hide-env"

    "source"
    "source-env"

    "overlay"
    "register"

    "loop"
    "while"
    "error"

    "do"
    "if"
    "else"
    "try"
    "catch"
    "match"

    "break"
    "continue"
    "return"

] @keyword

(hide_mod "hide" @include)
(decl_use "use" @include)

(ctrl_for
    "for" @repeat
    "in" @conditional
)
(overlay_list "list" @keyword)
(overlay_hide "hide" @include)
(overlay_new "new" @keyword)
(overlay_use
    "use" @include
    "as" @include
)
(ctrl_error "make" @keyword)

;;; ---
;;; literals
(val_number) @number
(val_duration
    unit: [
        "ns" "µs" "us" "ms" "sec" "min" "hr" "day" "wk"
    ] @number
)
(val_filesize
    unit: [
        "b" "B"

        "kb" "kB" "Kb" "KB"
        "mb" "mB" "Mb" "MB"
        "gb" "gB" "Gb" "GB"
        "tb" "tB" "Tb" "TB"
        "pb" "pB" "Pb" "PB"
        "eb" "eB" "Eb" "EB"
        "zb" "zB" "Zb" "ZB"

        "kib" "kiB" "kIB" "kIb" "Kib" "KIb" "KIB"
        "mib" "miB" "mIB" "mIb" "Mib" "MIb" "MIB"
        "gib" "giB" "gIB" "gIb" "Gib" "GIb" "GIB"
        "tib" "tiB" "tIB" "tIb" "Tib" "TIb" "TIB"
        "pib" "piB" "pIB" "pIb" "Pib" "PIb" "PIB"
        "eib" "eiB" "eIB" "eIb" "Eib" "EIb" "EIB"
        "zib" "ziB" "zIB" "zIb" "Zib" "ZIb" "ZIB"
    ] @number
)
(val_binary
    [
       "0b"
       "0o"
       "0x"
    ] @number
    "[" @punctuation.bracket
    digit: [
        "," @punctuation.delimiter
        (hex_digit) @number
    ]
    "]" @punctuation.bracket
) @number
(val_bool) @boolean
(val_nothing) @constant.builtin
(val_string) @string
(val_date) @string.special
(inter_escape_sequence) @string.escape
(escape_sequence) @string.escape
(val_interpolated [
    "$\""
    "$\'"
    "\""
    "\'"
] @string)
(unescaped_interpolated_content) @string
(escaped_interpolated_content) @string
(expr_interpolated ["(" ")"] @parameter)

;;; ---
;;; operators
(expr_binary [
    "+"
    "-"
    "*"
    "/"
    "mod"
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
    "starts-with"
    "ends-with"
] @operator )

(where_command [
    "+"
    "-"
    "*"
    "/"
    "mod"
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
    "starts-with"
    "ends-with"
] @operator)

(assignment [
    "="
    "+="
    "-="
    "*="
    "/="
    "++="
] @operator)

(expr_unary ["not" "-"] @operator)

(val_range [
    ".."
    "..="
    "..<"
] @operator)

["=>" "=" "|"] @operator

[
    "o>"   "out>"
    "e>"   "err>"
    "e+o>" "err+out>"
    "o+e>" "out+err>"
] @operator

;;; ---
;;; punctuation
[
    ","
    ";"
] @punctuation.delimiter

(param_short_flag "-" @parameter)
(param_long_flag ["--"] @parameter)
(long_flag ["--"] @parameter)
(param_rest "..." @punctuation.special)
(param_type [":"] @punctuation.delimiter)
(param_value ["="] @operator)
(param_cmd ["@"] @punctuation.delimiter)
(param_opt ["?"] @punctuation.special)

[
    "(" ")"
    "{" "}"
    "[" "]"
] @punctuation.bracket

(val_record
  (record_entry ":" @punctuation.delimiter))
;;; ---
;;; identifiers
(param_rest
    name: (_) @parameter)
(param_opt
    name: (_) @parameter)
(parameter
    param_name: (_) @parameter)
(param_cmd
    (cmd_identifier) @string)
(param_long_flag) @parameter
(param_short_flag) @parameter

(short_flag) @parameter
(long_flag) @parameter

(scope_pattern [(wild_card) @function])

(cmd_identifier) @function

(command
    "^" @punctuation.special
    head: (_) @function
)

"where" @function

(path
  "." @punctuation.delimiter
  "?" @punctuation.special
) @variable.parameter

(val_variable 
  "$" @variable
  [
   (identifier) @variable
   "in"
   "nu"
   "env"
   "nothing"
   ] @variable.builtin
)
;;; ---
;;; types
(flat_type) @type.builtin
(list_type
    "list" @type.builtin
    ["<" ">"] @punctuation.bracket
)
(collection_type
    ["record" "table"] @type.builtin
    "<" @punctuation.bracket
    key: (_) @type.builtin
    ["," ":"] @punctuation.delimiter
    ">" @punctuation.bracket
)

(shebang) @comment
(comment) @comment
