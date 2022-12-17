(
  (style_element
    (start_tag) @_no_lang
    (raw_text) @css)
  (#not-contains? @_no_lang "lang=")
) 

(
  (style_element
    (start_tag
      (attribute
        (quoted_attribute_value (attribute_value) @_lang)))
    (raw_text) @css)
  (#eq? @_lang "css")
)

; if start_tag does not specify `lang="..."` then set it to javascript
(
 (script_element
    (start_tag) @_no_lang 
  (raw_text) @javascript)
 (#not-contains? @_no_lang "lang=")
)

(
  (script_element
    (start_tag
      (attribute
        (quoted_attribute_value (attribute_value) @_lang)))
    (raw_text) @javascript)
  (#eq? @_lang "js")
)

(
  (style_element
    (start_tag
      (attribute
        (quoted_attribute_value (attribute_value) @_lang)))
    (raw_text) @scss)
  (#any-of? @_lang "scss" "postcss" "less")
)

(
  (script_element
    (start_tag
      (attribute
        (quoted_attribute_value (attribute_value) @_lang)))
    (raw_text) @typescript)
  (#eq? @_lang "ts")
)

((interpolation
  (raw_text) @javascript))

((directive_attribute
    (quoted_attribute_value
      (attribute_value) @javascript)))

(
  (template_element
    (start_tag
      (attribute
        (quoted_attribute_value (attribute_value) @_lang)))
    (text) @pug)
  (#eq? @_lang "pug")
)

(comment) @comment
