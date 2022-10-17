; <style>...</style>
(
  (style_element
    (start_tag
      (tag_name) .) 
    (raw_text) @css)
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
    (start_tag
      (tag_name) .) 
    (raw_text) @javascript)
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

; lit-html style template interpolation
((attribute
  (quoted_attribute_value (attribute_value) @javascript))
  (#match? @javascript "\\$\\{")
  (#offset! @javascript 0 2 0 -1))
((attribute
  (attribute_value) @javascript)
  (#match? @javascript "\\$\\{")
  (#offset! @javascript 0 2 0 -2))

(comment) @comment
