[
  "("
  ")"
  "{"
  "}"
  "["
  "]"
  "[["
  "]]"
  "(("
  "))"
] @punctuation.bracket

[
  ";"
  ";;"
  ";&"
  ";;&"
  "&"
] @punctuation.delimiter

[
  ">"
  ">>"
  "<"
  "<<"
  "&&"
  "|"
  "|&"
  "||"
  "="
  "+="
  "=~"
  "=="
  "!="
  "&>"
  "&>>"
  "<&"
  ">&"
  ">|"
  "<&-"
  ">&-"
  "<<-"
  "<<<"
  ".."
  "!"
] @operator

; Do *not* spell check strings since they typically have some sort of
; interpolation in them, or, are typically used for things like filenames, URLs,
; flags and file content.
[
  (string)
  (raw_string)
  (ansi_c_string)
  (heredoc_body)
] @string

[
  (heredoc_start)
  (heredoc_end)
] @label

(variable_assignment
  (word) @string)

; (command
;   argument: "variable_ref" @string) ; bare dollar
(concatenation
  (word) @string)

[
  "if"
  "then"
  "else"
  "elif"
  "fi"
  "case"
  "in"
  "esac"
] @keyword.conditional

[
  "for"
  "do"
  "done"
  "select"
  "until"
  "while"
] @keyword.repeat

[
  "declare"
  "typeset"
  "readonly"
  "local"
  "unset"
  "unsetenv"
] @keyword

"export" @keyword.import

"function" @keyword.function

(special_variable_name) @variable.builtin

; trap -l
((word) @constant.builtin
  (#any-of? @constant.builtin
    "SIGHUP" "SIGINT" "SIGQUIT" "SIGILL" "SIGTRAP" "SIGABRT" "SIGBUS" "SIGFPE" "SIGKILL" "SIGUSR1"
    "SIGSEGV" "SIGUSR2" "SIGPIPE" "SIGALRM" "SIGTERM" "SIGSTKFLT" "SIGCHLD" "SIGCONT" "SIGSTOP"
    "SIGTSTP" "SIGTTIN" "SIGTTOU" "SIGURG" "SIGXCPU" "SIGXFSZ" "SIGVTALRM" "SIGPROF" "SIGWINCH"
    "SIGIO" "SIGPWR" "SIGSYS" "SIGRTMIN" "SIGRTMIN+1" "SIGRTMIN+2" "SIGRTMIN+3" "SIGRTMIN+4"
    "SIGRTMIN+5" "SIGRTMIN+6" "SIGRTMIN+7" "SIGRTMIN+8" "SIGRTMIN+9" "SIGRTMIN+10" "SIGRTMIN+11"
    "SIGRTMIN+12" "SIGRTMIN+13" "SIGRTMIN+14" "SIGRTMIN+15" "SIGRTMAX-14" "SIGRTMAX-13"
    "SIGRTMAX-12" "SIGRTMAX-11" "SIGRTMAX-10" "SIGRTMAX-9" "SIGRTMAX-8" "SIGRTMAX-7" "SIGRTMAX-6"
    "SIGRTMAX-5" "SIGRTMAX-4" "SIGRTMAX-3" "SIGRTMAX-2" "SIGRTMAX-1" "SIGRTMAX"))

((word) @boolean
  (#any-of? @boolean "true" "false"))

(comment) @comment @spell

(test_operator) @operator

(command_substitution
  "$(" @punctuation.special
  ")" @punctuation.special)

(process_substitution
  [
    "<("
    ">("
  ] @punctuation.special
  ")" @punctuation.special)

(arithmetic_expansion
  [
    "$(("
    "(("
  ] @punctuation.special
  "))" @punctuation.special)

(arithmetic_expansion
  "," @punctuation.delimiter)

(ternary_expression
  [
    "?"
    ":"
  ] @keyword.conditional.ternary)

(binary_expression
  operator: _ @operator)

(unary_expression
  operator: _ @operator)

(postfix_expression
  operator: _ @operator)

(function_definition
  name: (word) @function)

(command_name
  (word) @function.call)

(command_name
  (word) @function.builtin
  (#any-of? @function.builtin
    "." ":" "alias" "bg" "bind" "break" "builtin" "caller" "cd" "command" "compgen" "complete"
    "compopt" "continue" "coproc" "dirs" "disown" "echo" "enable" "eval" "exec" "exit" "false" "fc"
    "fg" "getopts" "hash" "help" "history" "jobs" "kill" "let" "logout" "mapfile" "popd" "printf"
    "pushd" "pwd" "read" "readarray" "return" "set" "shift" "shopt" "source" "suspend" "test" "time"
    "times" "trap" "true" "type" "typeset" "ulimit" "umask" "unalias" "wait"))

(command
  argument: [
    (word) @variable.parameter
    (concatenation
      (word) @variable.parameter)
  ])

(declaration_command
  (word) @variable.parameter)

(unset_command
  (word) @variable.parameter)

(number) @number

((word) @number
  (#lua-match? @number "^[0-9]+$"))

(file_redirect
  (word) @string.special.path)

(herestring_redirect
  (word) @string)

(file_descriptor) @operator

(variable_ref
  "$" @punctuation.special)

(expansion
  "${" @punctuation.special
  "}" @punctuation.special)

"``" @punctuation.special

(array_star) @variable.builtin

(array_at) @variable.builtin

(expansion_flags) @attribute.builtin

(expansion_style) @attribute.builtin

(expansion_pattern
  pattern: "#" @attribute.builtin)

(expansion_modifier) @attribute.builtin

(simple_variable_name) @variable

(glob_pattern) @string.regexp

(variable_name) @variable

((variable_name) @constant
  (#lua-match? @constant "^[A-Z][A-Z_0-9]*$"))

((variable_name) @variable.builtin
  (#any-of? @variable.builtin
    ; POSIX shell variables
    "CDPATH" "HOME" "IFS" "MAIL" "MAILPATH" "OPTARG" "OPTIND" "PATH" "PS1" "PS2"
    ; https://zsh.sourceforge.io/Doc/Release/Parameters.html#Parameters-Set-By-The-Shell
    "_" "ARGC" "CPUTYPE" "DIRSTACK" "EGID" "EPOCHREALTIME" "EPOCHSECONDS" "ERRNO" "EUID"
    "FUNCFILETRACE" "FUNCNEST" "FUNCSOURCETRACE" "FUNCSTACK" "GID" "HISTCMD" "HOST" "LINENO"
    "LOGNAME" "MACHTYPE" "OLDPWD" "OSTYPE" "PIPESTATUS" "PPID" "PWD" "RANDOM" "SECONDS" "SHLVL"
    "TRY_BLOCK_ERROR" "TRY_BLOCK_INTERRUPT" "TTY" "TTYIDLE" "UID" "USERNAME" "VENDOR" "ZSH_ARGZERO"
    "ZSH_EVAL_CONTEXT" "ZSH_EXECUTION_STRING" "ZSH_NAME" "ZSH_PATCHLEVEL" "ZSH_SCRIPT"
    "ZSH_SUBSHELL" "ZSH_VERSION"
    ; ZLE parameters (set by shell) - https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html
    "BUFFER" "BUFFERLINES" "CONTEXT" "CURSOR" "CUTBUFFER" "HISTNO" "ISEARCHMATCH_ACTIVE"
    "ISEARCHMATCH_END" "ISEARCHMATCH_START" "KEYMAP" "KEYS" "KEYS_QUEUED_COUNT" "LASTABORTEDSEARCH"
    "LASTSEARCH" "LASTWIDGET" "LBUFFER" "MARK" "MATCH" "MBEGIN" "MEND" "NUMERIC" "PENDING"
    "POSTDISPLAY" "PREBUFFER" "PREDISPLAY" "PREFIX" "QIPREFIX" "QISUFFIX" "RBUFFER" "REGION_ACTIVE"
    "REPLY" "SAVECURSOR" "SUFFIX" "UNDO_CHANGE_NO" "UNDO_LIMIT_NO" "WIDGET" "WIDGETFUNC"
    "WIDGETSTYLE" "YANK_ACTIVE" "YANK_END" "YANK_START" "WORDS_STYLE" "ZLE_RECURSIVE" "ZLE_STATE"
    ; Completion parameters - https://zsh.sourceforge.io/Doc/Release/Completion-Widgets.html
    "CURRENT" "IPREFIX" "ISUFFIX" "compstate"
    ; https://zsh.sourceforge.io/Doc/Release/Parameters.html#Parameters-Used-By-The-Shell
    "ARGV0" "BAUD" "COLUMNS" "CORRECT_IGNORE" "CORRECT_IGNORE_FILE" "DIRSTACKSIZE" "EDITOR" "ENV"
    "FCEDIT" "FIGNORE" "FPATH" "HISTCHARS" "HISTFILE" "HISTSIZE" "KEYBOARD_HACK" "KEYTIMEOUT" "LANG"
    "LC_ALL" "LC_COLLATE" "LC_CTYPE" "LC_MESSAGES" "LC_NUMERIC" "LC_TIME" "LINES" "LISTMAX"
    "LOGCHECK" "MAILCHECK" "MANPATH" "MODULE_PATH" "NULLCMD" "POSTEDIT" "PROMPT" "PROMPT2" "PROMPT3"
    "PROMPT4" "PROMPTCHARS" "PS3" "PS4" "PSVAR" "READNULLCMD" "RPROMPT" "RPROMPT2" "RPS1" "RPS2"
    "SAVEHIST" "SHELL" "SPROMPT" "STTY" "TERM" "TIMEFMT" "TMOUT" "TMPPREFIX" "VISUAL" "WATCH"
    "WATCHFMT" "WORDCHARS" "ZBEEP" "ZDOTDIR" "ZLE_LINE_ABORTED" "ZLE_REMOVE_SUFFIX_CHARS"
    "ZLE_RPROMPT_INDENT" "ZLE_SPACE_SUFFIX_CHARS"
    ; Array/lowercase tied parameters - https://zsh.sourceforge.io/Doc/Release/Variables-Index.html
    "argv" "cdpath" "dirstack" "fignore" "fpath" "funcfiletrace" "funcsourcetrace" "funcstack"
    "functrace" "histchars" "killring" "mailpath" "manpath" "match" "mbegin" "mend" "module_path"
    "options" "path" "pipestatus" "prompt" "psvar" "reply" "signals" "status" "watch" "words"
    "zsh_eval_context"))

((simple_variable_name) @variable.builtin
  (#any-of? @variable.builtin
    ; POSIX shell variables
    "CDPATH" "HOME" "IFS" "MAIL" "MAILPATH" "OPTARG" "OPTIND" "PATH" "PS1" "PS2"
    ; https://zsh.sourceforge.io/Doc/Release/Parameters.html#Parameters-Set-By-The-Shell
    "_" "ARGC" "CPUTYPE" "DIRSTACK" "EGID" "EPOCHREALTIME" "EPOCHSECONDS" "ERRNO" "EUID"
    "FUNCFILETRACE" "FUNCNEST" "FUNCSOURCETRACE" "FUNCSTACK" "GID" "HISTCMD" "HOST" "LINENO"
    "LOGNAME" "MACHTYPE" "OLDPWD" "OSTYPE" "PIPESTATUS" "PPID" "PWD" "RANDOM" "SECONDS" "SHLVL"
    "TRY_BLOCK_ERROR" "TRY_BLOCK_INTERRUPT" "TTY" "TTYIDLE" "UID" "USERNAME" "VENDOR" "ZSH_ARGZERO"
    "ZSH_EVAL_CONTEXT" "ZSH_EXECUTION_STRING" "ZSH_NAME" "ZSH_PATCHLEVEL" "ZSH_SCRIPT"
    "ZSH_SUBSHELL" "ZSH_VERSION"
    ; ZLE parameters (set by shell) - https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html
    "BUFFER" "BUFFERLINES" "CONTEXT" "CURSOR" "CUTBUFFER" "HISTNO" "ISEARCHMATCH_ACTIVE"
    "ISEARCHMATCH_END" "ISEARCHMATCH_START" "KEYMAP" "KEYS" "KEYS_QUEUED_COUNT" "LASTABORTEDSEARCH"
    "LASTSEARCH" "LASTWIDGET" "LBUFFER" "MARK" "MATCH" "MBEGIN" "MEND" "NUMERIC" "PENDING"
    "POSTDISPLAY" "PREBUFFER" "PREDISPLAY" "PREFIX" "QIPREFIX" "QISUFFIX" "RBUFFER" "REGION_ACTIVE"
    "REPLY" "SAVECURSOR" "SUFFIX" "UNDO_CHANGE_NO" "UNDO_LIMIT_NO" "WIDGET" "WIDGETFUNC"
    "WIDGETSTYLE" "YANK_ACTIVE" "YANK_END" "YANK_START" "WORDS_STYLE" "ZLE_RECURSIVE" "ZLE_STATE"
    ; Completion parameters - https://zsh.sourceforge.io/Doc/Release/Completion-Widgets.html
    "CURRENT" "IPREFIX" "ISUFFIX" "compstate"
    ; https://zsh.sourceforge.io/Doc/Release/Parameters.html#Parameters-Used-By-The-Shell
    "ARGV0" "BAUD" "COLUMNS" "CORRECT_IGNORE" "CORRECT_IGNORE_FILE" "DIRSTACKSIZE" "EDITOR" "ENV"
    "FCEDIT" "FIGNORE" "FPATH" "HISTCHARS" "HISTFILE" "HISTSIZE" "KEYBOARD_HACK" "KEYTIMEOUT" "LANG"
    "LC_ALL" "LC_COLLATE" "LC_CTYPE" "LC_MESSAGES" "LC_NUMERIC" "LC_TIME" "LINES" "LISTMAX"
    "LOGCHECK" "MAILCHECK" "MANPATH" "MODULE_PATH" "NULLCMD" "POSTEDIT" "PROMPT" "PROMPT2" "PROMPT3"
    "PROMPT4" "PROMPTCHARS" "PS3" "PS4" "PSVAR" "READNULLCMD" "RPROMPT" "RPROMPT2" "RPS1" "RPS2"
    "SAVEHIST" "SHELL" "SPROMPT" "STTY" "TERM" "TIMEFMT" "TMOUT" "TMPPREFIX" "VISUAL" "WATCH"
    "WATCHFMT" "WORDCHARS" "ZBEEP" "ZDOTDIR" "ZLE_LINE_ABORTED" "ZLE_REMOVE_SUFFIX_CHARS"
    "ZLE_RPROMPT_INDENT" "ZLE_SPACE_SUFFIX_CHARS"
    ; Array/lowercase tied parameters - https://zsh.sourceforge.io/Doc/Release/Variables-Index.html
    "argv" "cdpath" "dirstack" "fignore" "fpath" "funcfiletrace" "funcsourcetrace" "funcstack"
    "functrace" "histchars" "killring" "mailpath" "manpath" "match" "mbegin" "mend" "module_path"
    "options" "path" "pipestatus" "prompt" "psvar" "reply" "signals" "status" "watch" "words"
    "zsh_eval_context"))

((command
  name: (command_name
    (word) @_printf)
  .
  argument: (word) @_v
  .
  argument: (word) @variable)
  (#eq? @_printf "printf")
  (#eq? @_v "-v")
  (#lua-match? @variable "^[a-zA-Z_][a-zA-Z0-9_]*$"))

(case_item
  value: (word) @variable.parameter)

[
  (regex)
  (extglob_pattern)
] @string.regexp

((program
  .
  (comment) @keyword.directive @nospell)
  (#lua-match? @keyword.directive "^#![ \t]*/"))
