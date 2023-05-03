; inherits: html_tags

(frontmatter
  (raw_text) @injection.content
  (#set! injection.language "typescript"))

(interpolation
  (raw_text) @injection.content
  (#set! injection.language "tsx"))

(script_element
  (raw_text) @injection.content
  (#set! injection.language "typescript"))

(style_element
 (start_tag
   (attribute
     (attribute_name) @_lang_attr
     (quoted_attribute_value (attribute_value) @_lang_value)))
 (raw_text) @injection.content
 (#eq? @_lang_attr "lang")
 (#eq? @_lang_value "scss")
 (#set! injection.language "scss"))
