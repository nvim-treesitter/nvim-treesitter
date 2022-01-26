[
 (quoted_argument)
 (bracket_argument)
] @string

(variable_ref) @none
(variable) @variable

[
 (bracket_comment)
 (line_comment)
] @comment

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
    (argument) @_cache @constant
    .
    (argument) @_type @constant
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

((argument) @boolean
  (#match? @boolean "\\c^(1|on|yes|true|y|0|off|no|false|n|ignore|notfound|.*-notfound)$")
)

(if_condition
  (_
    (_)
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
  (argument) @constant
  (#any-of? @constant "RESULT" "QUERY")
  (#match? @function.builtin "\\c^(cmake_host_system_information)$")
)

(normal_command
  (identifier) @function.builtin
  (argument) @constant
  (#any-of? @constant "CALL" "EVAL" "CODE" "DEFER" "CALL")
  (#match? @function.builtin "\\c^(cmake_language)$")
)

(normal_command
  (identifier) @function.builtin
  (argument) @constant
  (#any-of? @constant "VERSION" "FATAL_ERROR")
  (#match? @function.builtin "\\c^(cmake_minimum_required)$")
)

(normal_command
  (identifier) @function.builtin
  (argument) @constant
  (#any-of? @constant "PARSE_ARGV")
  (#match? @function.builtin "\\c^(cmake_parse_arguments)$")
)

(normal_command
  (identifier) @function.builtin
  (argument) @constant
  (#any-of? @constant "GET" "ROOT_NAME" "ROOT_DIRECTORY" "ROOT_PATH" "FILENAME" "EXTENSION" "STEM" "RELATIVE_PART" "PARENT_PATH"
                      "HAS_ROOT_NAME" "HAS_ROOT_DIRECTORY" "HAS_ROOT_PATH" "HAS_FILENAME" "HAS_EXTENSION" "HAS_STEM" "HAS_RELATIVE_PATH" "HAS_PARENT_PATH"
                      "IS_ABSOLUTE" "IS_RELATIVE" "IS_PREFIX" "COMPARE"
                      "SET" "APPEND" "APPEND_STRING" "REMOVE_FILENAME" "REPLACE_FILENAME" "REMOVE_EXTENSION" "REPLACE_EXTENSION"
                      "NORMAL_PATH" "RELATIVE_PATH" "ABSOLUTE_PATH"
                      "NATIVE_PATH" "CONVERT" "TO_CMAKE_PATH_LIST" "TO_NATIVE_PATH_LIST"
                      "HASH"
                      "NORMALIZE" "OUTPUT_VARIABLE" "LAST_ONLY")
  (#match? @function.builtin "\\c^(cmake_path)$")
)

(normal_command
  (identifier) @function.builtin
  (argument) @constant
  (#any-of? @constant "VERSION" "SET" "NEW" "OLD" "GET" "PUSH" "POP")
  (#match? @function.builtin "\\c^(cmake_policy)$")
)

(normal_command
  (identifier) @function.builtin
  (argument) @constant
  (#any-of? @constant "NO_SOURCE_PERMISSIONS" "USE_SOURCE_PERMISSIONS" "FILE_PERMISSIONS"
                      "COPYONLY" "ESCAPE_QUOTES" "@ONLY"
                      "NEWLINE_STYLE" "UNIX" "DOS" "WIN32" "LF" "CRLF")
  (#match? @function.builtin "\\c^(configure_file)$")
)
