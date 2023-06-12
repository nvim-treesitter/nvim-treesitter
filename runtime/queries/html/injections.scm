; inherits html_tags
(element
  (start_tag
    (tag_name) @_py_script)
  (text) @injection.content
  (#any-of? @_py_script "py-script" "py-repl")
  (#set! injection.language "python"))

(script_element
  (start_tag
    (attribute
      (attribute_name) @_attr
      (quoted_attribute_value
        (attribute_value) @_type)))
  (raw_text) @injection.content
  (#eq? @_attr "type")
  ; not adding type="py" here as it's handled by html_tags
  (#any-of? @_type "pyscript" "py-script")
  (#set! injection.language "python"))

(element
  (start_tag
    (tag_name) @_py_config)
  (text) @injection.content
  (#eq? @_py_config "py-config")
  (#set! injection.language "toml"))
