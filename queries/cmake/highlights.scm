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
  . (argument) @constant
  . (argument) @variable
  . (argument) @constant
  (#any-of? @constant "RESULT" "QUERY")
  (#nth? @variable 2)
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

(normal_command
  (identifier) @function.builtin
  (argument) @constant
  (#any-of? @constant "COMMAND" "WORKING_DIRECTORY" "TIMEOUT"
                      "RESULT_VARIABLE" "RESULTS_VARIABLE" "OUTPUT_VARIABLE" "ERROR_VARIABLE"
                      "INPUT_FILE" "OUTPUT_FILE" "ERROR_FILE"
                      "OUTPUT_QUIET" "ERROR_QUIET" "COMMAND_ECHO"
                      "OUTPUT_STRIP_TRAILING_WHITESPACE" "ERROR_STRIP_TRAILING_WHITESPACE"
                      "ENCODING"
                      "ECHO_OUTPUT_VARIABLE" "ECHO_ERROR_VARIABLE"
                      "COMMAND_ERROR_IS_FATAL" "ANY" "LAST")
  (#match? @function.builtin "\\c^(execute_process)$")
)

(normal_command
  (identifier) @function.builtin
  (argument) @constant
  (#any-of? @constant "READ" "STRINGS"
                      "MD5" "SHA1" "SHA224" "SHA256" "SHA384" "SHA512" "SHA3_224" "SHA3_256" "SHA3_384" "SHA3_512"
                      "TIMESTAMP" "GET_RUNTIME_DEPENDENCIES"
                      "WRITE" "APPEND" "TOUCH" "TOUCH_NOCREATE" "GENERATE"  "CONFIGURE"
                      "GLOB" "GLOB_RECURSE" "MAKE_DIRECTORY" "REMOVE" "REMOVE_RECURSE" "RENAME" "COPY_FILE"
                      "COPY" "INSTALL" "SIZE" "READ_SYMLINK" "CREATE_LINK" "CHMOD"  "CHMOD_RECURSE"
                      "REAL_PATH" "RELATIVE_PATH" "TO_CMAKE_PATH" "TO_NATIVE_PATH"
                      "DOWNLOAD" "UPLOAD"
                      "LOCK"
                      "ARCHIVE_CREATE""ARCHIVE_EXTRACT"
                      "INPUT" "OUTPUT" "BASE_DIRECTORY" "PATHS" "EXPAND_TILDE" "CONTENT" "DESTINATION" "PERMISSIONS")
  (#match? @function.builtin "\\c^(file)$")
)

(normal_command
  (identifier) @function.builtin
  . (argument) @variable
  (argument)
  (#match? @function.builtin "\\c^(find_file|find_path)$")
)
(normal_command
  (identifier) @function.builtin
  . (argument) @variable
  (argument) @constant
  (#any-of? @constant "NAMES" "HINTS" "PATHS" "ENV" "PATH_SUFFIXES" "DOC" "NO_CACHE" "REQUIRED"
                      "NO_DEFAULT_PATH" "NO_PACKAGE_ROOT_PATH" "NO_CMAKE_PATH" "NO_CMAKE_ENVIRONMENT_PATH" "NO_SYSTEM_ENVIRONMENT_PATH"
                      "NO_CMAKE_SYSTEM_PATH"
                      "CMAKE_FIND_ROOT_PATH_BOTH" "ONLY_CMAKE_FIND_ROOT_PATH" "NO_CMAKE_FIND_ROOT_PATH")
  (#match? @function.builtin "\\c^(find_file|find_path)$")
)

(normal_command
  (identifier) @function.builtin
  . (argument) @variable
  (argument)
  (#match? @function.builtin "\\c^(find_library)$")
)
(normal_command
  (identifier) @function.builtin
  . (argument) @variable
  (argument) @constant
  (#any-of? @constant "NAMES" "NAMES_PER_DIR" "HINTS" "PATHS" "ENV" "PATH_SUFFIXES" "DOC" "NO_CACHE" "REQUIRED"
                      "NO_DEFAULT_PATH" "NO_PACKAGE_ROOT_PATH" "NO_CMAKE_PATH" "NO_CMAKE_ENVIRONMENT_PATH" "NO_SYSTEM_ENVIRONMENT_PATH"
                      "NO_CMAKE_SYSTEM_PATH"
                      "CMAKE_FIND_ROOT_PATH_BOTH" "ONLY_CMAKE_FIND_ROOT_PATH" "NO_CMAKE_FIND_ROOT_PATH")
  (#match? @function.builtin "\\c^(find_library|find_program)$")
)

(normal_command
  (identifier) @function.builtin
  (argument) @constant
  (#any-of? @constant "EXACT" "QUIET" "REQUIRED COMPONENTS" "OPTIONAL_COMPONENTS" "CONFIG|NO_MODULE" "NO_POLICY_SCOPE"
                      "NAMES" "CONFIGS" "HINTS" "PATHS" "PATH_SUFFIXES" "NO_DEFAULT_PATH" "NO_PACKAGE_ROOT_PATH"
                      "NO_CMAKE_PATH" "NO_CMAKE_ENVIRONMENT_PATH" "NO_SYSTEM_ENVIRONMENT_PATH" "NO_CMAKE_PACKAGE_REGISTRY"
                      "NO_CMAKE_SYSTEM_PATH" "NO_CMAKE_SYSTEM_PACKAGE_REGISTRY"
                      "CMAKE_FIND_ROOT_PATH_BOTH" "ONLY_CMAKE_FIND_ROOT_PATH" "NO_CMAKE_FIND_ROOT_PATH"
  (#match? @function.builtin "\\c^(find_package)$")
)
