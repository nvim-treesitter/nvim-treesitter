((style_element
  (start_tag (attribute (quoted_attribute_value (attribute_value) @_lang))?)
  (raw_text) @content)
 (#inject! @_lang "css"))

((script_element
  (start_tag (attribute (quoted_attribute_value (attribute_value) @_lang))?)
  (raw_text) @content)
 (#inject! @_lang "javascript"))

((interpolation
  (raw_text) @javascript))

((directive_attribute 
    (quoted_attribute_value 
      (attribute_value) @javascript)))

(comment) @comment
