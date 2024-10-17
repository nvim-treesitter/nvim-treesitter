(include_statement
  directive: _ @keyword.directive
  path: _ @string.special.path)

(comment) @comment @spell

(graph_section
  brackets_open: _ @punctuation.bracket
  name: _? @label
  brackets_close: _ @punctuation.bracket)

(task_section
  brackets_open: _ @punctuation.bracket
  name: (_
    (task_name) @function)
  brackets_close: _ @punctuation.bracket)

(top_section
  brackets_open: _ @punctuation.bracket
  name: _? @label
  brackets_close: _ @punctuation.bracket)

(sub_section_1
  brackets_open: _ @punctuation.bracket
  name: _? @label
  brackets_close: _ @punctuation.bracket)

(sub_section_2
  brackets_open: _ @punctuation.bracket
  name: _? @label
  brackets_close: _ @punctuation.bracket)

(runtime_section
  brackets_open: _ @punctuation.bracket
  name: _? @label
  brackets_close: _ @punctuation.bracket)

(graph_setting
  key: (_) @number
  operator: (_)? @operator)

(quoted_graph_string
  quotes_open: _ @string
  quotes_close: _ @string)

(multiline_graph_string
  quotes_open: _ @string
  quotes_close: _ @string)

[
  (graph_logical)
  (graph_arrow)
  (graph_parenthesis)
] @keyword.operator

(intercycle_annotation
  (recurrence) @number)

(graph_task
  xtrigger: _? @keyword.modifier
  suicide: _? @keyword.modifier
  name: _ @function)

(task_parameter
  "<" @punctuation.bracket
  name: (_)? @keyword.directive
  ","? @punctuation.delimiter
  "="? @operator
  selection: (_)? @keyword.directive
  ">" @punctuation.bracket)

(intercycle_annotation
  "[" @punctuation.bracket
  (recurrence)? @number
  "]" @punctuation.bracket)

(task_output
  ":" @tag
  (nametag) @variable.builtin)

(task_output
  "?"? @tag)

(setting
  key: (key) @variable
  operator: (_)? @operator
  value: [
    (unquoted_string) @string
    (quoted_string) @string
    (multiline_string) @string
    (boolean) @boolean
    (integer) @number
  ]?)

(datetime) @number.float

[
  (jinja2_expression)
  (jinja2_statement)
  (jinja2_comment)
  (jinja2_shebang)
] @keyword.directive

