((source_file
  .
  (comment) @keyword.directive @nospell)
  (#lua-match? @keyword.directive "^#!/"))

[
  "use"
  "no"
  "require"
] @keyword.import

[
  "if"
  "elsif"
  "unless"
  "else"
] @keyword.conditional

(conditional_expression
  [
    "?"
    ":"
  ] @keyword.conditional.ternary)

[
  "while"
  "until"
  "for"
  "foreach"
] @keyword.repeat

("continue" @keyword.repeat
  (block))

[
  "try"
  "catch"
  "finally"
] @keyword.exception

"return" @keyword.return

[
  "sub"
  "method"
] @keyword.function

[
  "async"
  "await"
] @keyword.coroutine

[
  "map"
  "grep"
  "sort"
] @function.builtin

[
  "package"
  "class"
  "role"
] @keyword.import

[
  "defer"
  "do"
  "eval"
  "my"
  "our"
  "local"
  "dynamically"
  "state"
  "field"
  "last"
  "next"
  "redo"
  "goto"
  "undef"
] @keyword

(_
  operator: _ @operator)

"\\" @operator

(yadayada) @keyword.exception

(phaser_statement
  phase: _ @keyword)

(class_phaser_statement
  phase: _ @keyword)

[
  "or"
  "xor"
  "and"
  "eq"
  "equ"
  "eqr"
  "ne"
  "cmp"
  "lt"
  "le"
  "ge"
  "gt"
  "isa"
] @keyword.operator

(eof_marker) @keyword.directive

(data_section) @comment

(pod) @none

[
  (number)
  (version)
] @number

(boolean) @boolean

[
  (string_literal)
  (interpolated_string_literal)
  (quoted_word_list)
  (command_string)
  (heredoc_content)
  (replacement)
  (transliteration_content)
] @string

[
  (heredoc_token)
  (command_heredoc_token)
  (heredoc_end)
] @label

[
  (escape_sequence)
  (escaped_delimiter)
] @string.escape

(_
  modifiers: _ @character.special)

[
  (quoted_regexp)
  (match_regexp)
  (regexp_content)
] @string.regexp

(autoquoted_bareword) @string.special

(use_statement
  (package) @type)

(package_statement
  (package) @type)

(class_statement
  (package) @type)

(require_expression
  (bareword) @type)

(subroutine_declaration_statement
  name: (bareword) @function)

(method_declaration_statement
  name: (bareword) @function)

(attribute_name) @attribute

(attribute_value) @string

(label) @label

(statement_label
  label: _ @label)

(relational_expression
  operator: "isa"
  right: (bareword) @type)

(function_call_expression
  (function) @function.call)

(method_call_expression
  (method) @function.method.call)

(method_call_expression
  invocant: (bareword) @type)

(func0op_call_expression
  function: _ @function.builtin)

(func1op_call_expression
  function: _ @function.builtin)

; this was a regex for the CLI
([
  (function)
  (expression_statement
    (bareword))
] @function.builtin
  (#any-of? @function.builtin
    "accept" "atan2" "bind" "binmode" "bless" "crypt" "chmod" "chown" "connect" "die" "dbmopen"
    "exec" "fcntl" "flock" "formline" "getpriority" "getprotobynumber" "gethostbyaddr"
    "getnetbyaddr" "getservbyname" "getservbyport" "getsockopt" "glob" "index" "ioctl" "join" "kill"
    "link" "listen" "mkdir" "msgctl" "msgget" "msgrcv" "msgsend" "open" "opendir" "print" "printf"
    "push" "pack" "pipe" "return" "rename" "rindex" "read" "recv" "reverse" "say" "select" "seek"
    "semctl" "semget" "semop" "send" "setpgrp" "setpriority" "seekdir" "setsockopt" "shmctl"
    "shmread" "shmwrite" "shutdown" "socket" "socketpair" "split" "sprintf" "splice" "substr"
    "system" "symlink" "syscall" "sysopen" "sysseek" "sysread" "syswrite" "tie" "truncate" "unlink"
    "unpack" "utime" "unshift" "vec" "warn" "waitpid"))

(function) @function

(_
  "{" @punctuation.special
  (varname)
  "}" @punctuation.special)

(varname
  (block
    "{" @punctuation.special
    "}" @punctuation.special))

([
  (varname)
  (filehandle)
] @variable.builtin
  (#any-of? @variable.builtin
    "ENV" "ARGV" "INC" "ARGVOUT" "SIG" "STDIN" "STDOUT" "STDERR" "a" "b" "_"))

((varname) @variable.builtin
  ; highlights all the reserved ^ vars like ${^THINGS}
  (#lua-match? @variable.builtin "%^"))

((varname) @variable.builtin
  ; highlights punc vars and also numeric only like $11
  (#lua-match? @variable.builtin "^%A+$"))

[
  (scalar)
  (array)
  (hash)
  (glob)
  ; arraylen's sigil is kinda special b/c it's not a data type
  (arraylen
    "$#" @operator)
] @variable

; all post deref sigils highlighted as operators, and the unrolly star is a special char
(postfix_deref
  [
    "$"
    "@"
    "%"
    "*"
    "$#"
  ] @operator
  "*" @character.special)

(slices
  [
    arrayref: _
    hashref: _
  ]
  [
    "@"
    "%"
  ] @operator)

; except for subref deref, b/c that's actually a function call
(amper_deref_expression
  [
    "&"
    "*"
  ] @function.call)

; mark hash or glob keys that are any form of string in any form of access
(_
  "{"
  [
    (autoquoted_bareword)
    (_
      (string_content))
  ] @variable.member
  "}")

; mark stringies on the LHS of a fat comma as a hash key, b/c that's usually what it
; denotes somewhat
(_
  [
    (autoquoted_bareword)
    (_
      (string_content))
  ] @variable.member
  .
  "=>"
  (_))

(comment) @comment @spell

[
  "=>"
  ","
  ";"
  "->"
] @punctuation.delimiter

([
  "["
  "]"
  "{"
  "}"
  "("
  ")"
] @punctuation.bracket
  ; priority hack so nvim + ts-cli behave the same
  (#set! priority 90))
