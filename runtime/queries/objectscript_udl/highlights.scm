(pattern_expression) @string.regexp

(numeric_literal) @number

(string_literal) @string

(keyword_pound_pound_class) @keyword

(keyword_pound_pound_super) @keyword

(system_defined_variable) @variable.builtin

(system_defined_function) @function.builtin

(sql_field_modifier) @keyword.modifier

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

; I didn't include ( or ) in this, because they are often grouped
; as part of a sequence that gets turned into a single token, so they
; don't get matched, and one ends up getting colored differently than the other.
[
  "_"
  ","
  ":"
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

[
  (keyword_for)
  (keyword_while)
  (keyword_continue)
] @keyword.repeat

[
  (keyword_if)
  (keyword_elseif)
  (keyword_else)
  (keyword_oldelse)
] @keyword.conditional

[
  (keyword_throw)
  (keyword_try)
  (keyword_catch)
] @keyword.exception

[
  (keyword_return)
  (keyword_quit)
] @keyword.return

[
  (keyword_break)
  (keyword_debug)
  (keyword_trace)
  (keyword_step)
  (keyword_nostep)
  (keyword_stepmethod)
] @keyword.debug

[
  (keyword_pound_define)
  (keyword_pound_def1arg)
  (keyword_pound_if)
  (keyword_pound_elseif)
  (keyword_pound_else)
  (keyword_pound_endif)
  (keyword_pound_ifdef)
  (keyword_pound_ifndef)
  (keyword_dim)
] @keyword.directive

[
  (keyword_pound_import)
  (keyword_pound_include)
] @keyword.import

[
  (keyword_as)
  (keyword_of)
  (keyword_public)
  (keyword_private)
  (keyword_methodimpl)
] @keyword.modifier

keyword: (_) @keyword

(embedded_js_special_case_complete) @punctuation.special

(embedded_sql_marker) @punctuation.special

(embedded_sql_reverse_marker) @punctuation.special

(html_marker) @punctuation.special

(html_marker_reversed) @punctuation.special

(attribute) @attribute

(open_keywords) @keyword.modifier

(use_keywords) @keyword.modifier

(close_parameter_option_value) @keyword.modifier

[
  (line_comment_1)
  (line_comment_2)
  (line_comment_3)
  (line_comment_4)
  (block_comment)
] @comment @spell

(tag) @tag

[
  (keyword_import)
  (keyword_include)
  (keyword_includegenerator)
] @keyword.import

[
  (keyword_method)
  (keyword_classmethod)
] @keyword.function

[
  (keyword_class)
  (keyword_extends)
  (keyword_property)
  (keyword_relationship)
  (keyword_foreignkey)
  (keyword_parameter)
  (keyword_projection)
  (keyword_index)
  (keyword_query)
  (keyword_trigger)
  (keyword_xdata)
  (keyword_storage)
] @keyword.type

[
  (keyword_as)
  (keyword_of)
  (keyword_on)
  (keyword_not)
  (keyword_references)
] @keyword.modifier

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
] @keyword.modifier

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
