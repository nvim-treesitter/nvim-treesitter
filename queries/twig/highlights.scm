(comment) @comment

(filter_identifier) @function.call
(function_identifier) @function.call
(test) @function.builtin
(variable) @variable
(string) @string
(interpolated_string) @string
(operator) @operator
(number) @number
(boolean) @boolean
(null) @constant.builtin
(keyword) @keyword
(attribute) @attribute
(tag) @tag
(conditional) @conditional
(repeat) @repeat
(method) @method
(parameter) @parameter

[
    "{{"
    "}}"
    "{{-"
    "-}}"
    "{{~"
    "~}}"
    "{%"
    "%}"
    "{%-"
    "-%}"
    "{%~"
    "~%}"
] @tag.delimiter

[
    ","
    "."
    "?"
    ":"
    "="
] @punctuation.delimiter

(interpolated_string [
    "#{" 
    "}"
] @punctuation.delimiter)

[
    "("
    ")"
    "["
    "]"
    "{"
] @punctuation.bracket

(hash [
    "}"
] @punctuation.bracket)

