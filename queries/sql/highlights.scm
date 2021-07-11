(function_call
  name: (identifier) @function)

(table_expression
  name: (identifier) @type)

(table_expression
  name: (identifier) @type
  table_alias: (identifier) @variable)

(field
  table_alias: (identifier) @variable
  name: (identifier) @field)

((literal) @number
 (lua-match? @number "^%d+$"))

((literal) @string
 (lua-match? @string "^\"|'"))

[
  (keyword_select)
  (keyword_from)
  (keyword_where)
  (keyword_use)
  (keyword_index)
  (keyword_join)
  (keyword_on)
  (keyword_primary)
  (keyword_select)
  (keyword_delete)
  (keyword_create)
  (keyword_insert)
  (keyword_distinct)
  (keyword_replace)
  (keyword_update)
  (keyword_into)
  (keyword_values)
  (keyword_set)
  (keyword_from)
  (keyword_left)
  (keyword_right)
  (keyword_outer)
  (keyword_inner)
  (keyword_join)
  (keyword_on)
  (keyword_where)
  (keyword_order_by)
  (keyword_group_by)
  (keyword_having)
  (keyword_desc)
  (keyword_asc)
  (keyword_as)
  (keyword_limit)
  (keyword_offset)
  (keyword_primary)
  (keyword_table)
  (keyword_key)
  (keyword_constraint)
  (keyword_force)
  (keyword_use)
  (keyword_index)
  (keyword_for)
  (keyword_if)
  (keyword_exists)
  (keyword_auto_increment)
  (keyword_default)
] @keyword

[
  (keyword_in)
  (keyword_and)
  (keyword_or)
  (keyword_not)
] @keyword.operator

[
  "+"
  "-"
  "*"
  "/"
  "%"
  "^"
  "="
  "<"
  "<="
  "!="
  ">="
  ">"
] @operator

[
  "("
  ")"
] @punctuation.bracket

[
  ";"
  ","
  "."
] @punctuation.delimiter
