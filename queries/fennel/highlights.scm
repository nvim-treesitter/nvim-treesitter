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
  call: (symbol) @function.call)

(list
  call:
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
    "#" ":" "." "?." ".."))

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
  (#any-of? @keyword.conditional "if" "when" "case" "case-try" "match" "match-try"))

((symbol) @keyword
  (#any-of? @keyword
    "global" "local" "let" "set" "var" "comment" "do" "doc" "eval-compiler" "lua" "macro" "macros"
    "macrodebug" "unquote" "quote" "tset" "values" "tail!"))

((symbol) @keyword.import
  (#any-of? @keyword.import "require" "require-macros" "import-macros" "include"))

((symbol) @function.macro
  (#any-of? @function.macro
    "collect" "icollect" "fcollect" "accumulate" "faccumulate" "->" "->>" "-?>" "-?>>" "?." "doto"
    "partial" "pick-args" "pick-values" "with-open"
    ; compiler scope
    "list" "sym" "gensym" "list?" "sym?" "table?" "sequence?" "varg?" "multi-sym?" "comment?" "view"
    "get-scope" "assert-compile" "in-scope?" "macroexpand"))

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
    key: (symbol) @punctuation.special
    (#eq? @punctuation.special ":")))

(table
  (table_pair
    key: (symbol) @keyword.directive
    (#eq? @keyword.directive "&as")))

; List destructuring support for `let`
(list
  call: (symbol) @keyword
  (#eq? @keyword "let")
  .
  (comment)*
  .
  (sequence
    .
    ((comment)*
      .
      item:
        [
          (_)
          (list
            call: (symbol) @variable)
        ].
      (comment)*
      .
      item: (_).
      (comment)*)*))

; List destructuring support for "variable forms"
(list
  call: (symbol) @keyword
  (#any-of? @keyword "local" "var" "set" "global")
  .
  (comment)*
  .
  (list
    call: (symbol) @variable))

(list
  call: (symbol) @keyword.import
  (#eq? @keyword.import "import-macros")
  .
  (comment)*
  .
  (table
    (table_pair
      value: (symbol) @function.macro)))

(list
  call: (symbol) @keyword
  (#eq? @keyword "macro")
  .
  (comment)*
  .
  (symbol) @function.macro
  .
  (comment)*
  .
  [
    (sequence
      !item)
    (sequence
      [
        (symbol) @variable.parameter
        ((symbol) @punctuation.special
          (#eq? @punctuation.special "&"))
        ((symbol) @variable.builtin
          (#eq? @variable.builtin "..."))
      ])
  ])

(list
  call: (symbol) @keyword
  (#eq? @keyword "macros")
  .
  (comment)*
  .
  (table
    (table_pair
      key:
        (string
          ":"? @function.macro
          (string_content) @function.macro))))

; Function definition (without metadata/docstring)
(list
  call: (symbol) @keyword.function
  (#any-of? @keyword.function "fn" "lambda" "λ")
  .
  (comment)*
  .
  [
    (symbol) @function
    (multi_symbol
      (symbol_fragment) @function .)
  ]?
  .
  (comment)*
  .
  [
    (sequence
      !item)
    (sequence
      [
        (symbol) @variable.parameter
        ((symbol) @punctuation.special
          (#eq? @punctuation.special "&"))
        ((symbol) @variable.builtin
          (#eq? @variable.builtin "..."))
      ])
  ])

; Function definition with docstring
(list
  call: (symbol) @keyword.function
  (#any-of? @keyword.function "fn" "lambda" "λ")
  .
  (comment)*
  .
  [
    (symbol)
    (multi_symbol
      (symbol_fragment) .)
  ]?
  .
  (comment)*
  .
  [
    (sequence
      !item)
    (sequence
      (symbol))
  ]
  .
  (comment)*
  .
  ((string) @string.documentation
    .
    (comment)*
    .
    item: (_))?)

; Function definition with table metadata
(list
  call: (symbol) @keyword.function
  (#any-of? @keyword.function "fn" "lambda" "λ")
  .
  (comment)*
  .
  [
    (symbol)
    (multi_symbol
      (symbol_fragment) .)
  ]?
  .
  (comment)*
  .
  [
    (sequence
      !item)
    (sequence
      (symbol))
  ]
  .
  (comment)*
  .
  ((string)?
    .
    (comment)*
    .
    (table
      (table_pair
        key:
          (string
            (string_content) @string
            (#eq? @string "fnl/docstring"))
        value: (string) @string.documentation))
    .
    (comment)*
    .
    item: (_))?)

; Function definition with table arglist metadata
(list
  call: (symbol) @keyword.function
  (#any-of? @keyword.function "fn" "lambda" "λ")
  .
  (comment)*
  .
  [
    (symbol)
    (multi_symbol
      (symbol_fragment) .)
  ]?
  .
  (comment)*
  .
  [
    (sequence
      !item)
    (sequence
      (symbol))
  ]
  .
  (comment)*
  .
  ((string)?
    .
    (comment)*
    .
    (table
      (table_pair
        key:
          (string
            (string_content) @string
            (#eq? @string "fnl/arglist"))
        value:
          [
            (sequence
              !item)
            (sequence
              [
                (symbol) @variable.parameter
                ((symbol) @punctuation.special
                  (#eq? @punctuation.special "&"))
                ((symbol) @variable.builtin
                  (#eq? @variable.builtin "..."))
              ])
          ]))
    .
    (comment)*
    .
    item: (_))?)

; Table comprehension macros destructuring support
(list
  call:
    [
      ((symbol) @function.macro
        (#any-of? @function.macro "collect" "icollect"))
      ((symbol) @keyword.repeat
        (#eq? @keyword.repeat "each"))
    ]
  .
  (comment)*
  .
  (sequence
    .
    (comment)*
    .
    [
      (comment)
      (list
        call: (_) @variable)
      (sequence)
      (table)
      ((symbol) @variable
        (#lua-match? @variable "^[^&]"))
    ]*
    .
    [
      (list)
      (sequence)
      (table)
      ((symbol) @_variable
        (#lua-match? @_variable "^[^&]"))
    ]
    .
    (comment)*
    .
    [
      (string)
      (symbol)
    ]? @_option
    (#lua-match? @_option "^[&:]")))

(list
  call: (symbol) @function.macro
  (#eq? @function.macro "accumulate")
  .
  (comment)*
  .
  (sequence
    .
    (comment)*
    .
    (symbol)
    .
    (comment)*
    .
    ; HACK: Just (_) won't work since it will also capture (comment)
    ; TODO: Remove `item:` once tree-sitter/tree-sitter#1454 is resolved
    item: (_)
    .
    (comment)*
    .
    [
      (comment)
      (list
        call: (_) @variable)
      (sequence)
      (table)
      ((symbol) @variable
        (#lua-match? @variable "^[^&]"))
    ]*
    .
    [
      (list)
      (sequence)
      (table)
      ((symbol) @_variable
        (#lua-match? @_variable "^[^&]"))
    ]
    .
    (comment)*
    .
    [
      (string)
      (symbol)
    ]? @_option
    (#lua-match? @_option "^[&:]")))

; Iterator &until option
(list
  call:
    [
      ((symbol) @function.macro
        (#any-of? @function.macro "collect" "icollect" "fcollect" "accumulate" "faccumulate"))
      ((symbol) @keyword.repeat
        (#any-of? @keyword.repeat "for" "each"))
    ]
  .
  (comment)*
  .
  (sequence
    [
      (symbol)
      (string)
    ] @keyword.directive
    (#any-of? @keyword.directive "&until" ":until")))

; Iterator &into option
(list
  call: (symbol) @function.macro
  (#any-of? @function.macro "collect" "icollect" "fcollect")
  .
  (comment)*
  .
  (sequence
    [
      (symbol)
      (string)
    ] @keyword.directive
    (#any-of? @keyword.directive "&into" ":into")))

(list
  call: (symbol) @keyword.conditional
  (#any-of? @keyword.conditional "case" "match")
  .
  (comment)*
  .
  item: (_)
  .
  [
    (comment)
    ((list
      call:
        [
          (symbol) @variable
          ((symbol) @keyword
            (#eq? @keyword "where"))
        ])
      .
      (comment)*
      .
      item: (_))
  ]*
  .
  (list
    call:
      [
        (symbol) @variable
        ((symbol) @keyword
          (#eq? @keyword "where"))
      ]))

; Same as above, but for `-try` variants
(list
  call: (symbol) @keyword.conditional
  (#any-of? @keyword.conditional "case-try" "match-try")
  .
  (comment)*
  .
  item: (_)
  .
  [
    (comment)
    ((list
      call:
        [
          (symbol) @variable
          ((symbol) @keyword
            (#eq? @keyword "where"))
        ])
      .
      (comment)*
      .
      item: (_))
  ]*
  .
  (list
    call:
      [
        (symbol) @variable
        ((symbol) @keyword
          (#eq? @keyword "where"))
      ]))

; Catch block of `case-try` and `match-try`
(list
  call: (symbol) @keyword.conditional
  (#any-of? @keyword.conditional "case-try" "match-try")
  .
  (comment)*
  .
  item: (_)
  ; NOTE: I am not sure wether `catch` can appear anywhere or just at the end
  (list
    call: (symbol) @keyword @_catch
    (#eq? @_catch "catch")
    .
    [
      (comment)
      ((list
        call:
          [
            (symbol) @variable
            ((symbol) @_where
              (#eq? @_where "where"))
          ])
        .
        (comment)*
        .
        item: (_))
    ]*
    .
    (list
      call:
        [
          (symbol) @variable
          ((symbol) @keyword @_where
            (#eq? @_where "where"))
        ])?)
  .
  (comment)* .)

((list
  call: (symbol) @keyword
  (#eq? @keyword "comment")) @comment
  ; BUG: Offset for an unclosed list errors on Nightly *and* Stable:
  ; Invalid 'end_col': out of range
  ;
  ; With offset, parentheses are colored properly, without it, they're part
  ; of the comment (which is incorrect, but ok for now)
  ;
  ; (#offset! @comment 0 1 0 -1)
  (#set! "priority" 101))

(list
  call: (symbol) @keyword
  (#eq? @keyword "comment")
  (#set! "priority" 102))
