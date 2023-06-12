; inherits html_tags
; <script lang="css">
((style_element
  (start_tag
    (attribute
      (attribute_name) @_lang
      (quoted_attribute_value
        (attribute_value) @injection.language)))
  (raw_text) @injection.content)
  (#eq? @_lang "lang")
  (#any-of? @injection.language "css" "scss"))

; TODO: When nvim-treesitter has postcss and less parsers, use @injection.language and @injection.content instead
; <script lang="scss">
(style_element
  (start_tag
    (attribute
      (attribute_name) @_lang
      (quoted_attribute_value
        (attribute_value) @_scss)))
  (raw_text) @injection.content
  (#eq? @_lang "lang")
  (#any-of? @_scss "less" "postcss" "sass")
  (#set! injection.language "scss"))

; <script lang="js">
((script_element
  (start_tag
    (attribute
      (attribute_name) @_lang
      (quoted_attribute_value
        (attribute_value) @_js)))
  (raw_text) @injection.content)
  (#eq? @_lang "lang")
  (#eq? @_js "js")
  (#set! injection.language "javascript"))

; <script lang="ts">
((script_element
  (start_tag
    (attribute
      (attribute_name) @_lang
      (quoted_attribute_value
        (attribute_value) @_ts)))
  (raw_text) @injection.content)
  (#eq? @_lang "lang")
  (#eq? @_ts "ts")
  (#set! injection.language "typescript"))

; <script lang="tsx">
; <script lang="jsx">
(script_element
  (start_tag
    (attribute
      (attribute_name) @_attr
      (quoted_attribute_value
        (attribute_value) @injection.language)))
  (#eq? @_attr "lang")
  (#any-of? @injection.language "tsx" "jsx")
  (raw_text) @injection.content)

((interpolation
  (raw_text) @injection.content)
  (#set! injection.language "typescript"))

(directive_attribute
  (quoted_attribute_value
    (attribute_value) @injection.content
    (#set! injection.language "typescript")))

(template_element
  (start_tag
    (attribute
      (quoted_attribute_value
        (attribute_value) @injection.language)))
  (text) @injection.content
  (#eq? @injection.language "pug"))
