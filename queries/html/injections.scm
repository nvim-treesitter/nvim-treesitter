((style_element
  (raw_text) @css))

((attribute
   (attribute_name) @_attr
   (quoted_attribute_value (attribute_value) @css))
 (#eq? @_attr "style"))

(comment) @comment

(element
   (self_closing_tag
      (tag_name) @_tagname (#eq? @_tagname "input")
      ((attribute
          (attribute_name) @_attr
          (quoted_attribute_value (attribute_value) @regex)))
       (#eq? @_attr "pattern")))

(element
   (start_tag
      (tag_name) @_tagname (#eq? @_tagname "input")
      ((attribute
          (attribute_name) @_attr
          (quoted_attribute_value (attribute_value) @regex)))
       (#eq? @_attr "pattern")))

(script_element
   (start_tag
      ((attribute
           (attribute_name) @_attr (#eq? @_attr "type")
           (quoted_attribute_value (attribute_value) @_type))
        (#any-of? @_type "module" "application/javascript")))
   (raw_text) @javascript)

(script_element
   (start_tag
      ((attribute (attribute_name) @_attr (#not-eq? @_attr "type"))))
   (raw_text) @javascript)

(script_element
   (start_tag
      ((attribute
           (attribute_name) @_attr (#eq? @_attr "type")
           (quoted_attribute_value (attribute_value) @_type))
    (#eq? @_type "application/graphql")))
   (raw_text) @graphql)

(script_element
   (start_tag
      ((attribute
           (attribute_name) @_attr (#eq? @_attr "type")
           (quoted_attribute_value (attribute_value) @_type))
     (#eq? @_type "text/markdown")))
   (raw_text) @markdown)

