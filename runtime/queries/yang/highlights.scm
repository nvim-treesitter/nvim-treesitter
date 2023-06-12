(comment) @comment @spell

; Module / submodule
[
  "module"
  "submodule"
] @keyword

; Keywords
(statement_keyword) @keyword

(statement_keyword
  "import") @keyword.import

(extension_keyword) @function

; Arguments
(built_in_type) @type.builtin

(number) @number

(boolean) @boolean

(date) @number

(range
  (_
    ".." @punctuation.special))

(range
  (_
    "|" @punctuation.special))

(quoted_range
  "\"" @string.special)

(quoted_range
  "'" @string.special)

(yang_version) @constant.builtin

(identifier) @variable

(node_identifier) @variable

(string) @string

(string
  (escape_sequence) @string.escape)

(unquoted_string) @string

(keypath) @string.special.path

; Always highlight the value of an enum statement as a constant
(enum_value) @constant

; Highlight xpath and pattern strings differently from plain strings
(statement
  (statement_keyword
    "must")
  (argument
    (string) @string.special))

(statement
  (statement_keyword
    "pattern")
  (argument
    (string) @string.regexp))

; Punctuation
(plus_symbol) @operator

[
  "{"
  "}"
] @punctuation.bracket

";" @punctuation.delimiter
