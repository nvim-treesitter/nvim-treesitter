[
 (bracket_content)
 (quoted_element)
 (unquoted_argument)
] @parameter

(variable) @variable

[
 "$ENV"
 "$CACHE"
] @variable.builtin

(normal_command (identifier) @function)
[
 (function)
 (endfunction)
 (macro)
 (endmacro)
 (message)
] @function

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

[
 "1"
 "ON"
 "YES"
 "TRUE"
 "Y"
 "0"
 "OFF"
 "NO"
 "FALSE"
 "N"
 "IGNORE"
 "NOTFOUND"
] @boolean


[
 "COMMAND"
 "POLICY"
 "TARGET"
 "TEST"
 "DEFINED"
 "CACHE"
 "ENV"
 "IN_LIST"
 "EXISTS"
 "IS_NEWER_THAN"
 "IS_DIRECTORY"
 "IS_SYMLINK"
 "IS_ABSOLUTE"
 "IN"
 "RANGE"
 "ZIP_LISTS"
 "LISTS"
 "ITEMS"
 "FATAL_ERROR"
 "SEND_ERROR"
 "WARNING"
 "AUTHOR_WARNING"
 "DEPRECATION"
 "NOTICE"
 "STATUS"
 "VERBOSE"
 "DEBUG"
 "TRACE"
 "CHECK_START"
 "CHECK_PASS"
 "CHECK_FAIL"
] @keyword

[
 "NOT"
 "AND"
 "OR"
 "MATCHES"
 "LESS"
 "GREATER"
 "EQUAL"
 "LESS_EQUAL"
 "GREATER_EQUAL"
 "STRLESS"
 "STRGREATER"
 "STREQUAL"
 "STRLESS_EQUAL"
 "STRGREATER_EQUAL"
 "VERSION_LESS"
 "VERSION_GREATER"
 "VERSION_EQUAL"
 "VERSION_LESS_EQUAL"
 "VERSION_GREATER_EQUAL"
] @keyword.operator
