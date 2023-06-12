; Most primitive nodes
(shebang) @keyword.directive

(comment) @comment @spell

[
  "("
  ")"
  "{"
  "}"
  "["
  "]"
] @punctuation.bracket

(nil) @constant.builtin

(boolean) @boolean

(number) @number

(string) @string

(escape_sequence) @string.escape

(symbol) @variable

(multi_symbol
  "." @punctuation.delimiter
  member: (symbol_fragment) @variable.member)

(list
  .
  (symbol) @function.call)

(list
  .
  (multi_symbol
    member: (symbol_fragment) @function.call .))

(multi_symbol_method
  ":" @punctuation.delimiter
  method: (symbol_fragment) @function.method.call .)

; Just `&` is only used in destructuring
((symbol) @punctuation.special
  (#eq? @punctuation.special "&"))

; BUG: $ arguments should only be valid inside hashfn of any depth, but
; it's impossible to express such query at the moment of writing.
; See tree-sitter/tree-sitter#880
((symbol) @variable.parameter
  (#eq? @variable.parameter "$..."))

((symbol) @variable.parameter
  (#lua-match? @variable.parameter "^%$[1-9]$"))

((symbol) @operator
  (#any-of? @operator
    ; arithmetic
    "+" "-" "*" "/" "//" "%" "^"
    ; comparison
    ">" "<" ">=" "<=" "=" "~="
    ; other
    "#" "." "?." ".."))

((symbol) @keyword.operator
  (#any-of? @keyword.operator
    ; comparison
    "not="
    ; boolean
    "and" "or" "not"
    ; bitwise
    "lshift" "rshift" "band" "bor" "bxor" "bnot"
    ; other
    "length"))

(reader_macro
  macro: "#" @keyword.function)

((symbol) @keyword.function
  (#any-of? @keyword.function "fn" "lambda" "λ" "hashfn"))

((symbol) @keyword.repeat
  (#any-of? @keyword.repeat "for" "each" "while"))

((symbol) @keyword.conditional
  (#any-of? @keyword.conditional "if" "when" "match" "case"))

((symbol) @keyword
  (#any-of? @keyword
    "global" "local" "let" "set" "var" "comment" "do" "doc" "eval-compiler" "lua" "macros" "unquote"
    "quote" "tset" "values" "tail!"))

((symbol) @keyword.import
  (#any-of? @keyword.import "require" "require-macros" "import-macros" "include"))

((symbol) @function.macro
  (#any-of? @function.macro
    "collect" "icollect" "fcollect" "accumulate" "faccumulate" "->" "->>" "-?>" "-?>>" "?." "doto"
    "macro" "macrodebug" "partial" "pick-args" "pick-values" "with-open"))

; TODO: Highlight builtin methods (`table.unpack`, etc) as @function.builtin
([
  (symbol) @module.builtin
  (multi_symbol
    base: (symbol_fragment) @module.builtin)
]
  (#any-of? @module.builtin
    "vim" "_G" "debug" "io" "jit" "math" "os" "package" "string" "table" "utf8"))

([
  (symbol) @variable.builtin
  (multi_symbol
    .
    (symbol_fragment) @variable.builtin)
]
  (#eq? @variable.builtin "arg"))

((symbol) @variable.builtin
  (#eq? @variable.builtin "..."))

((symbol) @constant.builtin
  (#eq? @constant.builtin "_VERSION"))

((symbol) @function.builtin
  (#any-of? @function.builtin
    "assert" "collectgarbage" "dofile" "error" "getmetatable" "ipairs" "load" "loadfile" "next"
    "pairs" "pcall" "print" "rawequal" "rawget" "rawlen" "rawset" "require" "select" "setmetatable"
    "tonumber" "tostring" "type" "warn" "xpcall" "module" "setfenv" "loadstring" "unpack"))

(table
  (table_pair
    key: (symbol) @keyword.directive
    (#eq? @keyword.directive "&as")))

(list
  .
  (symbol) @keyword.function
  (#any-of? @keyword.function "fn" "lambda" "λ")
  .
  [
    (symbol) @function
    (multi_symbol
      (symbol_fragment) @function .)
  ]
  .
  (sequence
    ((symbol) @variable.parameter
      (#not-any-of? @variable.parameter "&" "..."))))

(list
  .
  (symbol) @function.macro
  (#any-of? @function.macro "collect" "icollect" "fcollect")
  .
  (sequence
    [
      (symbol)
      (string)
    ] @keyword.directive
    (#any-of? @keyword.directive "&into" ":into")))

(list
  .
  (symbol) @function.macro
  (#any-of? @function.macro "for" "each" "collect" "icollect" "fcollect" "accumulate" "faccumulate")
  .
  (sequence
    [
      (symbol)
      (string)
    ] @keyword.directive
    (#any-of? @keyword.directive "&until" ":until")))

(list
  .
  (symbol) @keyword.conditional
  (#any-of? @keyword.conditional "match" "case")
  .
  (_)
  .
  ((list
    .
    (symbol) @keyword
    (#eq? @keyword "where"))
    .
    (_))*
  .
  (list
    .
    (symbol) @keyword
    (#eq? @keyword "where"))
  .
  (_)? .)
