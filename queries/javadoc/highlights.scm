[
 (tag_name)
 "include"
 "exclude"
] @nospell @keyword

(identifier) @nospell @variable

(fragment) @nospell @variable.member

(parameter
  name: (identifier) @variable.parameter)

(param_tag
  parameter_name: (identifier) @variable.parameter)

[
 (boolean_type)
 (integral_type)
 (floating_point_type)
] @nospell @type.builtin

(module
  (identifier) @module)

(type
  (identifier) @type)

(type_parameter
  (identifier) @type)

(method
  (identifier) @function)

(((method
    (identifier) @constructor)
    (#match? @constructor "^[A-Z]")))

(member
  (identifier) @variable.member)

((member
  (identifier) @constant)
  (#match? @constant "^[A-Z_][A-Z0-9_]+$"))

((member
  (identifier) @type)
  (#match? @type "^[A-Z].*[a-z]"))

[
  (string_literal)
  (indexword)
] @nospell @string

[
  (bare_format_string)
  (literal_format_string)
] @nospell @string.special

(url) @nospell @markup.link.url

(attribute
  name: (identifier) @nospell @property)

(system_property) @nospell @property

(unsigned_integer) @number

(code) @nospell @markup.raw

[
  "="
  ":"
] @operator

[
  "/"
  "."
  ","
  "..."
  "#"
  "##"
] @punctuation.delimiter

[
  "{"
  "}"
  "("
  ")"
  "["
  "]"
] @punctuation.bracket

(param_tag
  [
   "<"
   ">"
  ] @punctuation.bracket)
