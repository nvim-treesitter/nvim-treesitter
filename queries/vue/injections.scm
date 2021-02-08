((style_element
  (raw_text) @css))

; There's no queries for less, sass nor postcss.

((script_element
  (raw_text) @javascript))

(
  (script_element
    (start_tag
      (attribute
        (quoted_attribute_value (attribute_value) @_lang)))
    (raw_text) @typescript)
  (#match? @_lang "(ts|typescript)")
)

((interpolation
  (raw_text) @javascript))
