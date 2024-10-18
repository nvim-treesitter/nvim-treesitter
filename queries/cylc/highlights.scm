(comment) @comment @spell

(section_name) @label

(key) @property

(boolean) @boolean

(datetime) @number.float

(task_name) @function

(include_directive) @keyword.directive

[
  (integer)
  (recurrence)
] @number

[
  "["
  "]"
  "[["
  "]]"
  "[[["
  "]]]"
  "<"
  ">"
  (graph_parenthesis)
] @punctuation.bracket

[
  "\""
  "\"\"\""
  (unquoted_string)
  (quoted_string)
  (multiline_string)
] @string

[
  (xtrigger_annotation)
  (suicide_annotation)
] @keyword.modifier

[
  "="
  (assignment_operator)
  (graph_logical)
  (graph_arrow)
] @operator

(include_statement
  path: (_)? @string.special.path)

(task_parameter
  name: (_)? @keyword.directive
  selection: (_)? @keyword.directive)

(task_output
  ":" @tag
  (nametag) @variable.builtin
  "?"? @tag)

[
  (jinja2_expression)
  (jinja2_statement)
  (jinja2_comment)
  (jinja2_shebang)
] @keyword.directive
