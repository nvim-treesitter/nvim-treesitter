; inherits: html_tags

((style_element
    (start_tag
      (attribute
        (attribute_name) @_attr
        (quoted_attribute_value (attribute_value) @_lang)))
    (raw_text) @injection.content)
  (#eq? @_attr "lang")
  (#any-of? @_lang "scss" "postcss" "less")
  (#set! injection.language "scss")
  (#set! injection.include-children))

([
  (raw_text_expr)
  (raw_text_each)
] @injection.content
 (#set! injection.language "javascript")
 (#set! injection.include-children))

((script_element
    (start_tag
      (attribute
        (attribute_name) @_attr
        (quoted_attribute_value (attribute_value) @_lang)))
    (raw_text) @injection.content)
 (#eq? @_attr "lang") 
 (#any-of? @_lang "ts" "typescript")
 (#set! injection.language "typescript")
 (#set! injection.include-children))

((element
   (start_tag
     (attribute
       (attribute_name) @_attr
       (quoted_attribute_value
         (attribute_value) @injection.language)))
   (text) @injection.content)
 (#eq? @_attr "lang") 
 (#eq? @injection.language "pug")
 (#set! injection.include-children))
