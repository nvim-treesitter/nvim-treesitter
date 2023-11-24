
(comment) @comment
(string) @string
[ "true" "false" ] @boolean
["if" "else"] @conditional
["export" "alias" "set"] @keyword
["@" "==" "!=" "+" ":="] @operator
[ "(" ")" "[" "]" "{{" "}}" "{" "}"] @punctuation.bracket

(assignment (NAME) @variable)
(alias (NAME) @variable)
(value (NAME) @variable)
(parameter (NAME) @variable)

; Recipe definitions
(recipeheader (NAME) @function)
(dependency (NAME) @function)
(dependency (depcall (NAME) @function))
(parameter) @parameter
(depcall (expression (value (NAME) @parameter)))

; Fallback highlighting for recipe bodies
(recipe
  (body) @text.literal.block (#set! "priority" 90))
(shebang_recipe
  (shebang interpreter: (TEXT) @keyword) @comment
  (shebang_body) @text.literal.block (#set! "priority" 90))

; Ref: https://just.systems/man/en/chapter_26.html
(setting (NAME) @error)
(setting (NAME) @constant.builtin
  (#any-of? @constant.builtin 
    "allow-duplicate-recipes"
    "dotenv-filename"
    "dotenv-load"
    "dotenv-path"
    "export"
    "fallback"
    "ignore-comments"
    "positional-arguments"
    "shell"
    "tempdir"
    "windows-powershell"
    "windows-shell"))
; Special handling for the shell setting
(setting "shell" @constant.builtin)
(setting lang: (NAME) @string.special)

; Ref: https://just.systems/man/en/chapter_31.html
(call (NAME) @error)
(call (NAME) @function
  (#any-of? @function 
    "arch"
    "num_cpus"
    "os"
    "os_family"
    "env_var"
    "env_var_or_default"
    "env"
    "invocation_directory"
    "invocation_directory_native"
    "justfile"
    "justfile_directory"
    "just_executable"
    "quote"
    "replace"
    "replace_regex"
    "trim"
    "trim_end"
    "trim_end_match"
    "trim_end_matches"
    "trim_start"
    "trim_start_match"
    "trim_start_matches"
    "capitalize"
    "kebabcase"
    "lowercamelcase"
    "lowercase"
    "shoutykebabcase"
    "shoutysnakecase"
    "snakecase"
    "titlecase"
    "uppercamelcase"
    "uppercase"
    "absolute_path"
    "extension"
    "file_name"
    "file_stem"
    "parent_directory"
    "without_extension"
    "clean"
    "join"
    "path_exists"
    "error"
    "sha256"
    "sha256_file"
    "uuid"
    "semver_matches"))
