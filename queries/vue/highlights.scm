[
  (component)
  (template_element)
  (start_tag)
  (tag_name)
  (directive_attribute)
  (directive_dynamic_argument)
  (directive_dynamic_argument_value)
  (component)
  (end_tag)
] @tag

(erroneous_end_tag_name) @error
(attribute_name) @property
(attribute_value) @string
(quoted_attribute_value) @string
(comment) @comment

(text) @none
(element) @string
(interpolation) @punctuation.special
(interpolation
  (raw_text) @none)

[
  (directive_modifier)
  (directive_name)
  (directive_argument)
] @method

"=" @operator

[
 "<"
 ">"
 "</"
 "/>"
 ] @tag.delimiter
