; inherits: html_tags

(dynamic_directive_inner_value) @tag

[
  "["
  "]"
] @punctuation.bracket

(interpolation) @punctuation.special

(interpolation
  (raw_text) @none)

(directive_name) @tag.attribute

(directive_attribute
  (quoted_attribute_value) @punctuation.special)

(directive_attribute
  (quoted_attribute_value
    (attribute_value) @none))

[
  (directive_modifier)
  (directive_value)
] @function.method
