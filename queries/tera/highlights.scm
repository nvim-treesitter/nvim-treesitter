; Variables
;----------
(identifier) @variable

((identifier) @variable.builtin
  (#any-of? @variable.builtin "loop" "__tera_context"))

; Properties
;-----------
(member_expression
  property: (identifier)? @variable.member)

; Literals
;-----------
(string) @string

(bool) @boolean

(number) @number

; Tokens
;-----------
[
  "."
  ","
  "::"
  (frontmatter_delimiter)
] @punctuation.delimiter

[
  "*"
  "/"
  "%"
  "|"
  "+"
  "-"
  "~"
  "="
  "=="
  "!="
  "<"
  ">"
  "<="
  ">="
] @operator

[
  "("
  ")"
  "["
  "]"
  "{%"
  "%}"
  "-%}"
  "{%-"
  "}}"
  "{{"
  "-}}"
  "{{-"
] @punctuation.bracket

; Tags
;-----------
(comment_tag) @comment @spell

; Keywords
;-----------
[
  "if"
  "elif"
  "else"
  "endif"
] @keyword.conditional

[
  "for"
  "endfor"
] @keyword.repeat

[
  "include"
  "import"
  "extends"
] @keyword.import

[
  "in"
  "and"
  "or"
  "not"
  "is"
] @keyword.operator

[
  "break"
  "continue"
] @keyword.return

[
  "set"
  "set_global"
  "filter"
  "endfilter"
  "block"
  "endblock"
  "macro"
  "endmacro"
  "raw"
  "endraw"
  "as"
] @keyword

; Functions
;-----------
(macro_statement
  name: (identifier) @function
  (parameter_list
    parameter: (identifier) @variable.parameter
    (optional_parameter
      name: (identifier) @variable.parameter)))

(call_expression
  scope: (identifier)? @module
  name: (identifier) @function.call)

(call_expression
  scope: (identifier) @module.builtin
  name: (identifier) @function.call
  (#eq? @module.builtin "self"))

(call_expression
  name: (identifier) @function.builtin
  (#any-of? @function.builtin
    ; Functions - https://keats.github.io/tera/docs/#built-in-functions
    "range" "now" "throw" "get_random" "get_env"))

(test_expression
  test: (identifier) @function.call)

(test_expression
  test: (identifier) @function.builtin
  (#any-of? @function.builtin
    ; Tests - https://keats.github.io/tera/docs/#built-in-tests
    "defined" "undefined" "odd" "even" "string" "number" "divisibleby" "iterable" "object"
    "starting_with" "ending_with" "containing" "matching"))

(filter_expression
  filter: (identifier) @function.method.call)

; Namespaces
;-----------
(import_statement
  scope: (identifier) @module)
