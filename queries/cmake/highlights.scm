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

[
 (normal_command)
 (function_command)
 (endfunction_command)
 (macro_command)
 (endmacro_command)
 (message_command)
] @function

[
 (if_command)
 (elseif_command)
 (else_command)
 (endif_command)
] @conditional

[
 (foreach_command)
 (endforeach_command)
 (while_command)
 (endwhile_command)
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
 "NOT"
 "AND"
 "OR"
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

