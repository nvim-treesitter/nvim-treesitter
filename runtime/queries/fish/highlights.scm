; Fish highlighting
; Operators
[
  "&&"
  "||"
  "|"
  "&|"
  "2>|"
  "&"
  ".."
  "!"
  (direction)
  (stream_redirect)
] @operator

; match operators of test command
(command
  name: (word) @function.builtin
  (#eq? @function.builtin "test")
  argument: (word) @operator
  (#match? @operator "^(!?\\=|-[a-zA-Z]+)$"))

; match operators of [ command
(command
  name: (word) @punctuation.bracket
  (#eq? @punctuation.bracket "[")
  argument: (word) @operator
  (#match? @operator "^(!?\\=|-[a-zA-Z]+)$"))

[
  "not"
  "and"
  "or"
] @keyword.operator

; Conditionals
(if_statement
  [
    "if"
    "end"
  ] @keyword.conditional)

(switch_statement
  [
    "switch"
    "end"
  ] @keyword.conditional)

(case_clause
  "case" @keyword.conditional)

(else_clause
  "else" @keyword.conditional)

(else_if_clause
  [
    "else"
    "if"
  ] @keyword.conditional)

; Loops/Blocks
(while_statement
  [
    "while"
    "end"
  ] @keyword.repeat)

(for_statement
  [
    "for"
    "end"
  ] @keyword.repeat)

(begin_statement
  [
    "begin"
    "end"
  ] @keyword.repeat)

; Keywords
[
  "in"
  (break)
  (continue)
] @keyword

"return" @keyword.return

; Punctuation
[
  "["
  "]"
  "{"
  "}"
  "("
  ")"
] @punctuation.bracket

"," @punctuation.delimiter

; Commands
(command
  argument: [
    (word) @variable.parameter
    (#lua-match? @variable.parameter "^[-]")
  ])

(command_substitution
  "$" @punctuation.special)

; non-builtin command names
(command
  name: (word) @function.call)

; derived from builtin -n (fish 3.2.2)
(command
  name: [
    (word) @function.builtin
    (#any-of? @function.builtin
      "." ":" "_" "alias" "argparse" "bg" "bind" "block" "breakpoint" "builtin" "cd" "command"
      "commandline" "complete" "contains" "count" "disown" "echo" "emit" "eval" "exec" "exit" "fg"
      "functions" "history" "isatty" "jobs" "math" "printf" "pwd" "random" "read" "realpath" "set"
      "set_color" "source" "status" "string" "test" "time" "type" "ulimit" "wait")
  ])

; Functions
(function_definition
  [
    "function"
    "end"
  ] @keyword.function)

(function_definition
  name: [
    (word)
    (concatenation)
  ] @function)

(function_definition
  option: [
    (word)
    (concatenation
      (word))
  ] @variable.parameter
  (#lua-match? @variable.parameter "^[-]"))

; Strings
[
  (double_quote_string)
  (single_quote_string)
] @string

(escape_sequence) @string.escape

; Variables
(variable_name) @variable

(variable_expansion) @constant

(variable_expansion
  "$" @punctuation.special) @none

; Reference: https://fishshell.com/docs/current/language.html#special-variables
((variable_name) @variable.builtin
  (#any-of? @variable.builtin
    "PATH" "CDPATH" "LANG" "LC_ALL" "LC_COLLATE" "LC_CTYPE" "LC_MESSAGES" "LC_MONETARY" "LC_NUMERIC"
    "LC_TIME" "fish_color_normal" "fish_color_command" "fish_color_keyword" "fish_color_keyword"
    "fish_color_redirection" "fish_color_end" "fish_color_error" "fish_color_param"
    "fish_color_valid_path" "fish_color_option" "fish_color_comment" "fish_color_selection"
    "fish_color_operator" "fish_color_escape" "fish_color_autosuggestion" "fish_color_cwd"
    "fish_color_cwd_root" "fish_color_user" "fish_color_host" "fish_color_host_remote"
    "fish_color_status" "fish_color_cancel" "fish_color_search_match" "fish_color_history_current"
    "fish_pager_color_progress" "fish_pager_color_background" "fish_pager_color_prefix"
    "fish_pager_color_completion" "fish_pager_color_description"
    "fish_pager_color_selected_background" "fish_pager_color_selected_prefix"
    "fish_pager_color_selected_completion" "fish_pager_color_selected_description"
    "fish_pager_color_secondary_background" "fish_pager_color_secondary_prefix"
    "fish_pager_color_secondary_completion" "fish_pager_color_secondary_description"
    "fish_term24bit" "fish_term256" "fish_ambiguous_width" "fish_emoji_width"
    "fish_autosuggestion_enabled" "fish_handle_reflow" "fish_key_bindings" "fish_escape_delay_ms"
    "fish_sequence_key_delay_ms" "fish_complete_path" "fish_cursor_selection_mode"
    "fish_function_path" "fish_greeting" "fish_history" "fish_trace" "FISH_DEBUG"
    "FISH_DEBUG_OUTPUT" "fish_user_paths" "umask" "BROWSER" "_" "argv" "CMD_DURATION" "COLUMNS"
    "LINES" "fish_kill_signal" "fish_killring" "fish_read_limit" "fish_pid" "history" "HOME"
    "hostname" "IFS" "last_pid" "PWD" "pipestatus" "SHLVL" "status" "status_generation" "TERM"
    "USER" "EUID" "version" "FISH_VERSION"))

; Nodes
[
  (integer)
  (float)
] @number

(comment) @comment

(comment) @spell

((word) @boolean
  (#any-of? @boolean "true" "false"))

((program
  .
  (comment) @keyword.directive @nospell)
  (#lua-match? @keyword.directive "^#!/"))
