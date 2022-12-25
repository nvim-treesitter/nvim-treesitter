(
  (style_element
    (start_tag) @_no_attribute
    (raw_text) @css)
  (#match? @_no_attribute "^\\<\\s*style\\s*\\>$")
  ; unsure why, but without escaping &lt; and &gt; the query breaks
) 

(
  (style_element
    (start_tag
      (attribute
        (attribute_name) @_no_lang))
    (raw_text) @css)
  (#not-eq? @_no_lang "lang")
) 

(
  (style_element
    (start_tag
      (attribute
        (attribute_name) @_lang
        (quoted_attribute_value (attribute_value) @_css)))
    (raw_text) @css)
  (#eq? @_lang "lang")
  (#eq? @_css "css")
)

; If script tag does not have any extra attributes, set it to javascript
(
  (script_element
    (start_tag) @_no_attribute
    (raw_text) @javascript)
  (#match? @_no_attribute "^\\<\\s*script\\s*\\>$")
) 

; if start_tag does not specify `lang="..."` then set it to javascript
(
 (script_element
    (start_tag
      (attribute
        (attribute_name) @_no_lang))
    (raw_text) @javascript)
 (#not-eq? @_no_lang "lang")
)

(
  (script_element
    (start_tag
      (attribute
        (attribute_name) @_lang
        (quoted_attribute_value (attribute_value) @_js)))
    (raw_text) @javascript)
  (#eq? @_lang "lang")
  (#eq? @_js "js")
)

; TODO: When nvim-treesitter have postcss and less parser, use @language and @content instead
(
  (style_element
    (start_tag
      (attribute
        (attribute_name) @_lang
        (quoted_attribute_value (attribute_value) @_scss)))
    (raw_text) @scss)
  (#eq? @_lang "lang")
  (#any-of? @_scss "scss" "less" "postcss")
)

(
  (script_element
    (start_tag
      (attribute
        (attribute_name) @_lang
        (quoted_attribute_value (attribute_value) @_ts)))
    (raw_text) @typescript)
  (#eq? @_lang "lang")
  (#eq? @_ts "ts")
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
