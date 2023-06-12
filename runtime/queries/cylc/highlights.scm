(comment) @comment @spell

(key) @property

(boolean) @boolean

(datetime) @string.special

(task_name) @function

(include_directive) @keyword.import

[
  (section_name)
  (namespace)
] @markup.heading

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
] @attribute

[
  "="
  (assignment_operator)
  (graph_logical)
  (graph_arrow)
] @operator

(include_statement
  path: (_)? @string.special.path)

(task_parameter
  name: (_)? @variable.parameter
  selection: (_)? @variable.parameter)

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
