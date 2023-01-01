; inherits html_tags

; <script lang="css">
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

; TODO: When nvim-treesitter have postcss and less parser, use @language and @content instead
; <script lang="scss">
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

; <script lang="js">
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

; <script lang="ts">
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
