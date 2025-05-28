[
  "true"
  "false"
] @boolean

[
  "if"
  "else"
] @keyword.conditional

[
  "alias"
  "set"
  "shell"
  "mod"
] @keyword

[
  "import"
  "export"
] @keyword.import

[
  ":="
  "?"
  "=="
  "!="
  "=~"
  "@"
  "="
  "$"
  "*"
  "+"
  "&&"
  "@-"
  "-@"
  "-"
  "/"
  ":"
] @operator

[
  "("
  ")"
  "["
  "]"
  "{{"
  "}}"
  "{"
  "}"
] @punctuation.bracket

[
  "`"
  "```"
] @punctuation.special

"," @punctuation.delimiter

(shebang) @keyword.directive

(comment) @comment @spell

[
  (string)
  (external_command)
] @string

(escape_sequence) @string.escape

(module
  (identifier) @module)

(assignment
  (identifier) @variable)

(alias
  (identifier) @variable)

(value
  (identifier) @variable)

; Recipe definitions
(recipe_header
  (identifier) @function)

(dependency
  (identifier) @function.call)

(dependency_expression
  (identifier) @function.call)

(parameter
  (identifier) @variable.parameter)

(dependency_expression
  (expression
    (value
      (identifier) @variable.parameter)))

; Fallback highlighting for recipe bodies
(recipe
  (recipe_body) @string
  (#set! priority 90))

; Ref: https://just.systems/man/en/chapter_26.html
;(setting (identifier) @error)
(setting
  (identifier) @constant.builtin
  (#any-of? @constant.builtin
    "allow-duplicate-recipes" "dotenv-filename" "dotenv-load" "dotenv-path" "export" "fallback"
    "ignore-comments" "positional-arguments" "tempdir" "windows-powershell" "windows-shell"))

(recipe
  (attribute
    (identifier) @attribute))

; https://just.systems/man/en/attributes.html
((recipe
  (attribute
    (identifier) @attribute.builtin))
  (#any-of? @attribute.builtin
    "confirm" "doc" "extension" "group" "linux" "macos" "no-cd" "no-exit-message" "no-quiet"
    "openbsd" "positional-arguments" "private" "script" "unix" "windows" "working-directory"))

((recipe
  (attribute
    (identifier) @_doc
    argument: (string) @string.documentation))
  (#eq? @_doc "doc"))

((recipe
  (attribute
    (identifier) @_dir
    argument: (string) @string.special.path))
  (#eq? @_dir "working-directory"))

(function_call
  (identifier) @function.call)
