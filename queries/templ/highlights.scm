; inherits: go

(component_declaration
  name: (component_identifier) @function)

[
  (tag_start)
  (tag_end)
  (self_closing_tag)
  (style_element)
] @tag

(attribute
  name: (attribute_name) @tag.attribute)
(attribute
  value: (quoted_attribute_value) @string)

[
  (element_text)
  (style_element_text)
] @string.special

(css_identifier) @function
(css_property
  name: (css_property_name) @attribute)
(css_property
  value: (css_property_value) @attribute)

[
  (expression)
  (dynamic_class_attribute_value)
] @method

(component_import
  name: (component_identifier) @function)

(component_render) @function.call

(element_comment) @comment @spell

"@" @operator

[
  "templ"
  "css"
  "script"
] @keyword
