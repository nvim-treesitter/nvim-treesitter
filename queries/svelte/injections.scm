((style_element
  (raw_text) @css))

((script_element
  (raw_text) @javascript))

((raw_text_expr) @javascript)

(
  (script_element
    (start_tag
      (attribute
        (quoted_attribute_value (attribute_value) @_lang)))
    (raw_text) @typescript)
  (#match? @_lang "(ts|typescript)")
)
