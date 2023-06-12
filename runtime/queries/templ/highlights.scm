; inherits: go

(component_declaration
  name: (component_identifier) @function)

[
  (tag_start)
  (tag_end)
  (self_closing_tag)
  (style_element)
] @tag

(doctype) @constant

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
  name: (css_property_name) @property)

(css_property
  value: (css_property_value) @string)

[
  (expression)
  (dynamic_class_attribute_value)
] @function.method

(component_import
  name: (component_identifier) @function)

(component_render) @function.call

(element_comment) @comment @spell

[
  "<"
  ">"
  "</"
  "/>"
  "<!"
] @tag.delimiter

"@" @operator

[
  "templ"
  "css"
  "script"
] @keyword
