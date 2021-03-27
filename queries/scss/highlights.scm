; inherits: css

[
  "@mixin"
  "@media"
  "@while"
  "@each"
  "@include"
] @keyword

(function_name) @function


[
  ">="
  "<="
] @operator


(mixin_statement (name) @function)
(mixin_statement (parameters (parameter) @parameter))
(plain_value) @string
(keyword_query) @function
(identifier) @variable
(variable_name) @variable

(each_statement (key) @parameter)
(each_statement (value) @parameter)
(each_statement (variable_value) @parameter)

(argument) @parameter
(arguments (variable_value) @parameter)

[
  "["
  "]"
] @punctuation.bracket

(include_statement (identifier) @function)
