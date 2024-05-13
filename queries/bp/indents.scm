(list_expression) @indent.begin

(list_expression
  "]" @indent.branch)

(map_expression) @indent.begin

(map_expression
  "}" @indent.branch)

(select_expression) @indent.begin

(select_expression
  ")" @indent.branch)

(select_value) @indent.begin

(select_value
  ")" @indent.branch)

(select_pattern
  "(" @indent.begin)

(select_pattern
  ")" @indent.branch)

(select_cases) @indent.begin

(select_cases
  "}" @indent.branch)

(module) @indent.begin

(module
  ")" @indent.branch)

(module
  "}" @indent.branch)
