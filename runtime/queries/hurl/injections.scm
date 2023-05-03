; injections.scm
((json_value) @injection.content
 (#set! injection.language "json"))

((xml) @injection.content
 (#set! injection.language "html"))

(multiline_string
  (multiline_string_type) @_lang
  (multiline_string_content) @injection.content
  (#inject-language! @_lang))
