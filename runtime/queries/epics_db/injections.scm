((comment) @injection.content
  (#set! injection.language "comment"))

((macro_expansion) @injection.content
  (#set! injection.language "epics_msi_template"))

((ccode) @injection.content
  (#set! injection.language "c"))

((json_value) @injection.content
  (#set! injection.language "json5"))

(field_descriptor
  (field_item) @_extra
  value: (string
    (string_text_fragment) @injection.content
    (#set! injection.language "c"))
  (#eq? @_extra "extra"))
