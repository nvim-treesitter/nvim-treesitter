[
  (keyword_from)
  (keyword_filter)
  (keyword_derive)
  (keyword_group)
  (keyword_aggregate)
  (keyword_sort)
  (keyword_take)
  (keyword_window)
  (keyword_join)
  (keyword_select)
  (keyword_switch)
  (keyword_inner)
  (keyword_right)
  (keyword_full)
  (keyword_in)
  (keyword_rolling)
  (keyword_rows)
  (keyword_expanding)
  (keyword_let)
  (keyword_prql)
  (keyword_switch)
  (keyword_append)
  (keyword_remove)
  (keyword_intersect)
] @keyword

(literal) @string

(assignment
  alias: (field) @field)

alias: (identifier) @field

(f_string) @string.special
(s_string) @string.special

(comment) @comment

(keyword_func) @keyword.function

(function_call
  (identifier) @function.call)

[
  "+"
  "-"
  "*"
  "/"
  "="
  "=="
  "<"
  "<="
  "!="
  ">="
  ">"
  "->"
  (bang)
] @operator

[
  "("
  ")"
  "["
  "]"
] @punctuation.bracket

[
  ","
  "."
  (pipe)
] @punctuation.delimiter

(literal
  (integer) @number)

(integer) @number

(literal
  (decimal_number) @float)

(decimal_number) @float

[
  (keyword_min)
  (keyword_max)
  (keyword_count)
  (keyword_count_distinct)
  (keyword_average)
  (keyword_avg)
  (keyword_sum)
  (keyword_stddev)
  (keyword_count)
] @function.call

[
 (keyword_side)
 (keyword_version)
 (keyword_target)
 (keyword_null)
 (keyword_format)
] @attribute

(target) @function.builtin

 [
  (date)
  (time)
  (timestamp)
] @string.special

[
  (keyword_left)
  (keyword_inner)
  (keyword_right)
  (keyword_full)
  (keyword_csv)
  (keyword_json)
] @method

[
  (keyword_true)
  (keyword_false)
] @boolean

[
 (keyword_and)
 (keyword_or)
] @keyword.operator

(function_definition
  (keyword_func)
  name: (identifier) @function)

(parameter
  (identifier) @parameter)

(variable
  (keyword_let)
  name: (identifier) @constant)
