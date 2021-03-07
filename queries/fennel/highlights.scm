(boolean) @boolean
(nil) @constant.builtin
(string) @string
(number) @number
(field) @constant
(comment) @comment
(identifier) @variable

[
 "fn"
 "lambda"
 "hashfn"
 "set"
 "tset"
 "λ"
 "global"
 "var"
 "local"
 "let"
 "do"
 "not"
 "not="
 "_ENV"
 "_G"
 "_VERSION"
 "arg"
 "assert"
 "collectgarbage"
 "coroutine"
 "debug"
 "dofile"
 "doto"
 "error"
 "eval-compiler"
 "gensym"
 "getmetatable"
 "in-scope?"
 "ipairs"
 "list"
 "list?"
 "load"
 "loadfile"
 "loadstring"
 "match"
 "macro"
 "macrodebug"
 "macroexpand"
 "macros"
 "multi-sym?"
 "next"
 "pairs"
 "package"
 "pcall"
 "print"
 "rawequal"
 "rawget"
 "rawlen"
 "rawset"
 "select"
 "sequence?"
 "setmetatable"
 "string"
 "sym"
 "sym?"
 "table"
 "table?"
 "tonumber"
 "tostring"
 "type"
 "unpack"
 "varg?"
 "xpcall"
] @keyword

[
 "require"
 "require-macros"
 "import-macros"
 "include"
 ] @include

[
  "each"
  "for"
  "while"
] @repeat

[
  "if"
  "when"
] @conditional

[
  "("
  ")"
  "{"
  "}"
  "["
  "]"
] @punctuation.bracket

; hash function
"#" @function

(function_definition
  name: (identifier) @function)

(lambda_definition
  name: (identifier) @function)

(function_call
  name: (identifier) @function)

(field_expression
   (identifier)
   "." @punctuation.delimiter
   (identifier) @function)

;; TODO: fix me
;(field_expression
   ;(identifier)
   ;(field) @function)

(parameters (identifier) @parameter)
