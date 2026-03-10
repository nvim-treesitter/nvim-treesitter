(pattern_expression) @string.regexp

(numeric_literal) @number

(string_literal) @string

(keyword_pound_pound_class) @keyword

(keyword_pound_pound_super) @keyword

(system_defined_variable) @variable.builtin

(system_defined_function) @variable.builtin

(sql_field_modifier) @variable.builtin

(property_name) @property

(method_name) @function

(parameter_name) @property

(class_name) @type

(macro) @constant

(routine_ref) @variable

(sql_field_identifier) @variable

(lvn) @variable

(gvn) @variable

(ssvn) @variable

(instance_variable) @variable

(objectscript_identifier) @variable

(method_arg) @variable.parameter

; I didn't include '(' or ')' in this, because they are often grouped
; as part of a sequence that gets turned into a single token, so they
; don't get matched, and one ends up getting colored differently than the other.
[
  "_"
  ","
  ":"
  "."
  ".."
  "..."
  "'["
  "']"
  "']]"
  "\""
  "\"\""
  "["
  "]"
  "]]"
  "{"
  "}"
  "/"
  "\\"
  "#"
  "|"
  "||"
  "$$"
  "--"
  ";"
  "//"
  "#;"
  "##;"
  "$"
] @punctuation.delimiter

[
  "'&"
  "&"
  "&&"
  "'<"
  "'="
  "'>"
  "^"
  "-"
  "^$"
  "+"
  "<"
  "<="
  "="
  ">"
  ">="
  "@"
  "*"
  "**"
  "'"
  "'!"
  "'?"
  "!"
  "?"
] @operator

(json_string_literal) @string

(json_boolean_literal) @boolean

(json_number_literal) @number

(json_null_literal) @string

(bracket) @punctuation.bracket

(locktype) @variable

(macro_arg) @variable

(macro_value) @constant.builtin

keyword: (_) @keyword

(embedded_js_special_case_complete) @punctuation.special

(embedded_sql_marker) @punctuation.special

(embedded_sql_reverse_marker) @punctuation.special

(html_marker) @punctuation.special

(html_marker_reversed) @punctuation.special

(attribute) @attribute

(open_keywords) @attribute

(use_keywords) @attribute

(close_parameter_option_value) @attribute

; Cannot combine all of these into a supertype as for some reason, it messes up the scanner and doesn't match correctly.
[
  (line_comment_1)
  (line_comment_2)
  (line_comment_3)
  (line_comment_4)
  (block_comment)
] @comment @spell

(tag) @tag

; ------------------ UDL -------------------
[
  (method_keyword_codemode_expression)
  (call_method_keyword)
  (method_keyword)
  (class_keywords)
  (query_keywords)
  (trigger_keyword)
  (method_keyword_language)
  (relationship_keyword)
  (foreignkey_keyword)
  (parameter_keyword)
  (projection_keyword)
  (index_keyword)
  (index_keyword_extent)
  (xdata_keyword)
  (xdata_keyword_mimetype)
  (property_keyword)
] @attribute

(documatic_line) @comment.documentation

(query_name) @property

(property_name) @property

(relationship_name) @property

(foreignkey_name) @property

(parameter_name) @property

(projection_name) @property

(index_name) @property

(xdata_name) @property

(storage_name) @property

(return_type) @type.builtin

(typename) @type

(parameter_type) @type.builtin

(index_type) @type.builtin

(projection_type) @type.builtin

(property_type) @type.builtin

(index_property_type) @type.builtin

(identifier) @variable
