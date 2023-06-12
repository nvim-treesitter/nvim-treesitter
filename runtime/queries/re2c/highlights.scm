; Namespaces

[
  "re2c"
  "re2c"
  "local"
  "rules"
] @namespace

; Includes

[
  "!use"
  "!include"
] @include

; Keywords

[
  "flags"
  "define"
  "cond"
  "label"
  "variable"
  "yych"
  "state"
  "yybm"
  "cgoto"
  "api"
  "tags"
  "indent"
  "yyfill"
  "eof"
  "sentinel"
  "condprefix"
  "condenumprefix"
  "labelprefix"
  "startlabel"
  "posix-captures"
  "max"
  "maxnmatch"
  "mtags"
  "stags"
  "header"
  "getstate"
] @keyword

[
  "*"
  "+"
  "?"
] @repeat

; Constants

[
  "ignore"
  "substitute"
  "fail"
  "default"
  "custom"
  "match-empty"
  "match-none"
  "error"
  "functions"
  "free-form"
  "format"
  "separator"
] @constant.builtin

(linedir) @constant.macro

; Operators

[
  "="
  "=>"
  ":=>"
  "/"
  "|"
  "\\"
  "->"
  "^"
] @operator

[
  "."
  (default)
  (end_of_input)
] @constant.macro

(field_expression
  "." @operator)

(condition
  (any) @constant.macro)


; Names

(name) @type

(block_name) @constant

(label) @label

(option_name) @constant.builtin

((option_name) @constant.macro
 (#match? @constant.macro "^YY"))

(field_expression
  argument: (identifier) @variable)

(field_identifier) @property

; Literals

(regex) @string.regex

[
  (dstring) ; case   sensitive
  (sstring) ; case insensitive
] @string

[
  (quote)
  (ctrl_code)
  (code_unit)
] @string.escape

(number) @number

[
  "on"
  "off"
] @boolean

[
  (stag)
  (mtag)
] @property

; Configurations

(define
  option: (option_name) @_yy
  value: (dstring) @type
  (#eq? @_yy "YYCTYPE")
  (#offset! @type 0 1 0 -1))

(set_header
  value: (dstring) @string.special @text.underline)

(host_lang) @none

; Punctuation

[
  ":"
  ";"
  ","
  "-"
] @punctuation.delimiter

[
  "{" "}"
  "[" "]"
  "(" ")"
  "<" ">"
] @punctuation.bracket

(repetition
  (limits
    ["{" "}"] @punctuation.bracket))

[
  "!"
  "@"
  "#"
] @punctuation.special

; Comments and error

[
  (comment)
  (ignore_block)
] @comment @spell
