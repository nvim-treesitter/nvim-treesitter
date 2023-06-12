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
  (#set! "priority" 90))

; Ref: https://just.systems/man/en/chapter_26.html
;(setting (identifier) @error)
(setting
  (identifier) @constant.builtin
  (#any-of? @constant.builtin
    "allow-duplicate-recipes" "dotenv-filename" "dotenv-load" "dotenv-path" "export" "fallback"
    "ignore-comments" "positional-arguments" "tempdir" "windows-powershell" "windows-shell"))

; Ref: https://just.systems/man/en/chapter_32.html
;(recipe (attribute (identifier) @error))
(recipe
  (attribute
    (identifier) @attribute)
  (#any-of? @attribute
    "confirm" "linux" "macos" "no-cd" "no-exit-message" "no-quiet" "private" "unix" "windows"))

; Ref: https://just.systems/man/en/chapter_31.html
;(function_call (identifier) @error)
(function_call
  (identifier) @function.call
  (#any-of? @function.call
    "arch" "num_cpus" "os" "os_family" "env_var" "env_var_or_default" "env" "invocation_directory"
    "invocation_directory_native" "justfile" "justfile_directory" "just_executable" "quote"
    "replace" "replace_regex" "trim" "trim_end" "trim_end_match" "trim_end_matches" "trim_start"
    "trim_start_match" "trim_start_matches" "capitalize" "kebabcase" "lowercamelcase" "lowercase"
    "shoutykebabcase" "shoutysnakecase" "snakecase" "titlecase" "uppercamelcase" "uppercase"
    "absolute_path" "extension" "file_name" "file_stem" "parent_directory" "without_extension"
    "clean" "join" "path_exists" "error" "sha256" "sha256_file" "uuid" "semver_matches"))
