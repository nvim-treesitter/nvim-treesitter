[
 (quoted_argument)
 (bracket_argument)
] @string

(variable_ref) @none
(variable) @variable

[
 (bracket_comment)
 (line_comment)
] @comment @spell

(normal_command (identifier) @function)

["ENV" "CACHE"] @symbol
["$" "{" "}" "<" ">"] @punctuation.special
["(" ")"] @punctuation.bracket

[
 (function)
 (endfunction)
 (macro)
 (endmacro)
] @keyword.function

[
 (if)
 (elseif)
 (else)
 (endif)
] @conditional

[
 (foreach)
 (endforeach)
 (while)
 (endwhile)
] @repeat

(normal_command
  (identifier) @repeat
  (#match? @repeat "\\c^(continue|break)$")
)
(normal_command
  (identifier) @keyword.return
  (#match? @keyword.return "\\c^return$")
)

(function_command
  (function)
  . (argument) @function
  (argument)* @parameter
)

(macro_command
  (macro)
  . (argument) @function.macro
  (argument)* @parameter
)

(block_def
  (block_command
    (block) @function.builtin
    (argument (unquoted_argument) @constant)
    (#any-of? @constant "SCOPE_FOR" "POLICIES" "VARIABLES" "PROPAGATE")
  )
  (endblock_command (endblock) @function.builtin)
)

(normal_command
  (identifier) @function.builtin
  . (argument) @variable
  (#match? @function.builtin "\\c^(set)$")
)

(normal_command
  (identifier) @function.builtin
  (#match? @function.builtin "\\c^(set)$")
  (
    (argument) @constant
    (#any-of? @constant "PARENT_SCOPE")
  ) .
)

(normal_command
  (identifier) @function.builtin
  (#match? @function.builtin "\\c^(set)$")
  . (argument)
  (
    (argument) @_cache @storageclass
    .
    (argument) @_type @type
    (#any-of? @_cache "CACHE")
    (#any-of? @_type "BOOL" "FILEPATH" "PATH" "STRING" "INTERNAL")
  )
)
(normal_command
  (identifier) @function.builtin
  (#match? @function.builtin "\\c^(set)$")
  . (argument)
  (argument) @_cache
  (#any-of? @_cache "CACHE")
  (
    (argument) @_force @constant
    (#any-of? @_force "FORCE")
  ) .
)

(normal_command
  (identifier) @function.builtin
  (#match? @function.builtin "\\c^(unset)$")
  . (argument) @variable
)
(normal_command
  (identifier) @function.builtin
  (#match? @function.builtin "\\c^(unset)$")
  . (argument)
  (argument) @storageclass
  (#any-of? @storageclass "CACHE" "PARENT_SCOPE")
)

(normal_command
  (identifier) @function.builtin
  (#match? @function.builtin "\\c^(list)$")
  . (argument) @constant
  (#any-of? @constant "LENGTH" "GET" "JOIN" "SUBLIST" "FIND")
  . (argument) @variable
  (argument) @variable . 
)
(normal_command
  (identifier) @function.builtin
  (#match? @function.builtin "\\c^(list)$")
  . (argument) @constant
  . (argument) @variable
  (#any-of? @constant "APPEND" "FILTER" "INSERT"
                      "POP_BACK" "POP_FRONT" "PREPEND"
                      "REMOVE_ITEM" "REMOVE_AT" "REMOVE_DUPLICATES"
                      "REVERSE" "SORT")
)
(normal_command
  (identifier) @function.builtin
  (#match? @function.builtin "\\c^(list)$")
  . (argument) @_transform @constant
  . (argument) @variable
  . (argument) @_action @constant
  (#match? @_transform "TRANSFORM")
  (#any-of? @_action "APPEND" "PREPEND" "TOUPPER" "TOLOWER" "STRIP" "GENEX_STRIP" "REPLACE")
)
(normal_command
  (identifier) @function.builtin
  (#match? @function.builtin "\\c^(list)$")
  . (argument) @_transform @constant
  . (argument) @variable
  . (argument) @_action @constant
  . (argument)? @_selector @constant
  (#match? @_transform "TRANSFORM")
  (#any-of? @_action "APPEND" "PREPEND" "TOUPPER" "TOLOWER" "STRIP" "GENEX_STRIP" "REPLACE")
  (#any-of? @_selector "AT" "FOR" "REGEX")
)

((argument) @boolean
  (#match? @boolean "\\c^(1|on|yes|true|y|0|off|no|false|n|ignore|notfound|.*-notfound)$")
)

(if_command
  (if)
  (argument) @keyword.operator
  (#any-of? @keyword.operator "NOT" "AND" "OR"
                              "COMMAND" "POLICY" "TARGET" "TEST" "DEFINED" "IN_LIST"
                              "EXISTS" "IS_NEWER_THAN" "IS_DIRECTORY" "IS_SYMLINK" "IS_ABSOLUTE"
                              "MATCHES"
                              "LESS" "GREATER" "EQUAL" "LESS_EQUAL" "GREATER_EQUAL"
                              "STRLESS" "STRGREATER" "STREQUAL" "STRLESS_EQUAL" "STRGREATER_EQUAL"
                              "VERSION_LESS" "VERSION_GREATER" "VERSION_EQUAL" "VERSION_LESS_EQUAL" "VERSION_GREATER_EQUAL"
  )
)

(normal_command
  (identifier) @function.builtin
  . (argument)
  (argument) @constant
  (#any-of? @constant "ALL" "COMMAND" "DEPENDS" "BYPRODUCTS" "WORKING_DIRECTORY" "COMMENT"
                   "JOB_POOL" "VERBATIM" "USES_TERMINAL" "COMMAND_EXPAND_LISTS" "SOURCES")
  (#match? @function.builtin "\\c^(add_custom_target)$")
)

(normal_command
  (identifier) @function.builtin
  (argument) @constant
  (#any-of? @constant "OUTPUT" "COMMAND" "MAIN_DEPENDENCY" "DEPENDS" "BYPRODUCTS" "IMPLICIT_DEPENDS" "WORKING_DIRECTORY"
                      "COMMENT" "DEPFILE" "JOB_POOL" "VERBATIM" "APPEND" "USES_TERMINAL" "COMMAND_EXPAND_LISTS")
  (#match? @function.builtin "\\c^(add_custom_command)$")
)

(normal_command
  (identifier) @function.builtin
  (#match? @function.builtin "\\c^include$")
  (argument) @constant
  (#any-of? @constant "OPTIONAL" "NO_POLICY_SCOPE")
)
(normal_command
  (identifier) @function.builtin
  (#match? @function.builtin "\\c^include$")
  (argument) @constant
  .
  (argument) @variable
  (#match? @constant "RESULT_VARIABLE")
)

(escape_sequence) @string.escape

((source_file . (line_comment) @preproc)
  (#match? @preproc "^#!/"))
