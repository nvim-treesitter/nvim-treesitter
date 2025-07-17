;; Tree-sitter highlights for GROQ language
;; This file defines syntax highlighting for GROQ in Neovim

;; Keywords
"select" @keyword
"asc" @keyword
"desc" @keyword
"in" @keyword.operator
"match" @keyword.operator

;; Operators
"==" @operator
"!=" @operator
">" @operator
">=" @operator
"<" @operator
"<=" @operator
"&&" @operator
"||" @operator
"!" @operator
"+" @operator
"-" @operator
"*" @operator
"/" @operator
"%" @operator
"**" @operator
".." @operator
"..." @operator
"=>" @operator
"->" @operator
"|" @operator

;; Punctuation
"(" @punctuation.bracket
")" @punctuation.bracket
"[" @punctuation.bracket
"]" @punctuation.bracket
"{" @punctuation.bracket
"}" @punctuation.bracket
"," @punctuation.delimiter
":" @punctuation.delimiter
"." @punctuation.delimiter

;; Literals
(string) @string
(number) @number
(true) @boolean
(false) @boolean
(null) @constant.builtin

;; Special references
(star) @constant.builtin
(parent) @constant.builtin
(this) @constant.builtin

;; Identifiers
(identifier) @variable

;; Parameters
(parameter) @variable.parameter

;; Function calls
(function_call
  (identifier) @function)

(order_function
  "order" @function.builtin)

;; Comments
(comment) @comment

;; Projections and objects
(projection
  "{" @punctuation.bracket
  "}" @punctuation.bracket)

(object
  "{" @punctuation.bracket
  "}" @punctuation.bracket)

;; Conditional projections
(conditional_projection
  "=>" @operator)

;; Select statements
(select_statement
  "..." @operator
  "select" @keyword
  "=>" @operator)

;; Spread operators
(spread_operator
  "..." @operator)

;; Array access
(attribute_access
  "." @punctuation.delimiter)

;; String keys in projections/objects
(pair
  (literal (string) @property))

;; Highlight field names in projections
(projection (identifier) @property)

;; Built-in functions (essential GROQ functions)
(function_call
  (identifier) @function.builtin
  (#eq? @function.builtin "count"))

(function_call
  (identifier) @function.builtin
  (#eq? @function.builtin "length"))

(function_call
  (identifier) @function.builtin
  (#eq? @function.builtin "defined"))

(function_call
  (identifier) @function.builtin
  (#eq? @function.builtin "references"))

(function_call
  (identifier) @function.builtin
  (#eq? @function.builtin "now"))

(function_call
  (identifier) @function.builtin
  (#eq? @function.builtin "dateTime"))

(function_call
  (identifier) @function.builtin
  (#eq? @function.builtin "coalesce"))

(function_call
  (identifier) @function.builtin
  (#eq? @function.builtin "unique"))

(function_call
  (identifier) @function.builtin
  (#eq? @function.builtin "max"))

(function_call
  (identifier) @function.builtin
  (#eq? @function.builtin "min"))

(function_call
  (identifier) @function.builtin
  (#eq? @function.builtin "sum"))

(function_call
  (identifier) @function.builtin
  (#eq? @function.builtin "avg"))

(function_call
  (identifier) @function.builtin
  (#eq? @function.builtin "round"))

(function_call
  (identifier) @function.builtin
  (#eq? @function.builtin "floor"))

(function_call
  (identifier) @function.builtin
  (#eq? @function.builtin "ceil"))

(function_call
  (identifier) @function.builtin
  (#eq? @function.builtin "abs"))

(function_call
  (identifier) @function.builtin
  (#eq? @function.builtin "sqrt"))

(function_call
  (identifier) @function.builtin
  (#eq? @function.builtin "upper"))

(function_call
  (identifier) @function.builtin
  (#eq? @function.builtin "lower"))

(function_call
  (identifier) @function.builtin
  (#eq? @function.builtin "string"))

(function_call
  (identifier) @function.builtin
  (#eq? @function.builtin "number"))

(function_call
  (identifier) @function.builtin
  (#eq? @function.builtin "boolean"))

(function_call
  (identifier) @function.builtin
  (#eq? @function.builtin "array"))

(function_call
  (identifier) @function.builtin
  (#eq? @function.builtin "object"))

(function_call
  (identifier) @function.builtin
  (#eq? @function.builtin "type"))

(function_call
  (identifier) @function.builtin
  (#eq? @function.builtin "global"))

(function_call
  (identifier) @function.builtin
  (#eq? @function.builtin "sanity"))

(function_call
  (identifier) @function.builtin
  (#eq? @function.builtin "path"))

(function_call
  (identifier) @function.builtin
  (#eq? @function.builtin "delta"))

(function_call
  (identifier) @function.builtin
  (#eq? @function.builtin "after"))

(function_call
  (identifier) @function.builtin
  (#eq? @function.builtin "before"))

;; Error highlighting
(ERROR) @error