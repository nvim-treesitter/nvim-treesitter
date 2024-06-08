((comment) @injection.content
  (#set! injection.language "comment"))

((javascript) @injection.content
  (#set! injection.language "javascript"))

((attribute_name) @_attribute_name
  (quoted_attribute_value
    (attribute_value) @injection.content
    (#set! injection.language "javascript"))
  (#match? @_attribute_name "^(:|v-bind|v-|\\@)"))
