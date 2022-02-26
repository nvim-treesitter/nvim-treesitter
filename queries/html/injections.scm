; <style>
((style_element
  (raw_text) @css))

; <div style=".some-css { display: none; }">
((attribute
   (attribute_name) @_attr
   (quoted_attribute_value (attribute_value) @css))
 (#eq? @_attr "style"))

; <!-- comments -->
(comment) @comment

; <input pattern="[0-9]">
(element
   (_
      (tag_name) @_tagname (#eq? @_tagname "input")
      ((attribute
          (attribute_name) @_attr
          (quoted_attribute_value (attribute_value) @regex)
       (#eq? @_attr "pattern")))))
; <input pattern=[0-9]>
(element
   (_
      (tag_name) @_tagname (#eq? @_tagname "input")
      ((attribute
          (attribute_name) @_attr
          (attribute_value) @regex
       (#eq? @_attr "pattern")))))

; <script>
(script_element
   (start_tag (tag_name) .)
   (raw_text) @javascript)

; <script async defer>
(script_element
   (start_tag
      ((attribute (attribute_name) @_attr (#not-eq? @_attr "type"))))
   (raw_text) @javascript)

; <script type="${someJsMimetype}">
(script_element
   (start_tag
      ((attribute
           (attribute_name) @_attr (#eq? @_attr "type")
           (quoted_attribute_value (attribute_value) @_type))
        (#any-of? @_type "module"
                         "application/ecmascript"
                         "application/javascript"
                         "text/ecmascript"
                         "text/javascript"
        )))
   (raw_text) @javascript)

(script_element
   (start_tag
      ((attribute
           (attribute_name) @_attr (#eq? @_attr "type")
           (quoted_attribute_value (attribute_value) @_type))
    (#eq? @_type "application/json")))
   (raw_text) @json)

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


