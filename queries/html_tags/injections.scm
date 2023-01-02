; <style>...</style>
(
  (style_element
    (start_tag) @_no_attribute
    (raw_text) @css)
  (#match? @_no_attribute "^\\<\\s*style\\s*\\>$")
  ; unsure why, but without escaping &lt; and &gt; the query breaks
) 

; <style blocking> ...</style>
; Add "lang" to predicate check so that vue/svelte can inherit this
; without having this element being captured twice
(
  (style_element
    (start_tag
      (attribute
        (attribute_name) @_no_set_type))
    (raw_text) @css)
  (#not-any-of? @_no_set_type "type" "lang")
) 

(
  (style_element
    (start_tag
      (attribute
        (attribute_name) @_type
        (quoted_attribute_value (attribute_value) @_css)))
    (raw_text) @css)
  (#eq? @_type "type")
  (#eq? @_css "text/css")
)

; <script>...</script>
(
  (script_element
    (start_tag) @_no_attribute
    (raw_text) @javascript)
  (#match? @_no_attribute "^\\<\\s*script\\s*\\>$")
) 

; <script defer>...</script>
(
  (script_element
    (start_tag
      (attribute
        (attribute_name) @_no_set_type))
    (raw_text) @javascript)
  (#not-any-of? @_no_set_type "type" "lang")
) 

(
  (script_element
    (start_tag
      (attribute
        (attribute_name) @_type
        (quoted_attribute_value (attribute_value) @_javascript)))
    (raw_text) @javascript)
  (#eq? @_type "type")
  (#eq? @_javascript "text/javascript")
)

((attribute
   (attribute_name) @_attr
   (quoted_attribute_value (attribute_value) @css))
 (#eq? @_attr "style"))

(comment) @comment
