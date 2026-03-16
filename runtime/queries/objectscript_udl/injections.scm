(embedded_html
  (angled_bracket_fenced_text) @injection.content
  (#set! injection.language "html"))

(embedded_sql
  (_
    (paren_fenced_text) @injection.content)
  (#set! injection.language "sql"))

(embedded_js
  [
    (angled_bracket_fenced_text)
    (embedded_js_special_case)
  ] @injection.content
  (#set! injection.language "javascript"))

(embedded_xml
  (angled_bracket_fenced_text) @injection.content
  (#set! injection.language "xml"))

([
  (line_comment_1)
  (line_comment_2)
  (line_comment_3)
  (block_comment)
] @injection.content
  (#set! injection.language "comment"))

(method_definition
  (external_method_keywords
    (method_keyword_language
      (rhs) @_lang))
  (external_method_body_content) @injection.content
  (#set! injection.include-children "true")
  (#match? @_lang "^[Pp][Yy][Tt][Hh][Oo][Nn]$")
  (#set! injection.language "python"))

(method_definition
  (external_method_keywords
    (method_keyword_language
      (rhs) @_lang))
  (external_method_body_content) @injection.content
  (#set! injection.include-children "true")
  (#match? @_lang "^[Tt][Ss][Qq][Ll]$")
  (#set! injection.language "tsql"))

(method_definition
  (external_method_keywords
    (method_keyword_language
      (rhs) @_lang))
  (external_method_body_content) @injection.content
  (#set! injection.include-children "true")
  (#match? @_lang "^[Ii][Ss][Pp][Ll]$")
  (#set! injection.language "ispl"))

((trigger
  (external_trigger
    (trigger_keywords
      (method_keyword_language
        (rhs) @_lang))
    (external_method_body_content) @injection.content))
  (#set! injection.include-children "true")
  (#match? @_lang "^[Pp][Yy][Tt][Hh][Oo][Nn]$")
  (#set! injection.language "python"))

((trigger
  (external_trigger
    (trigger_keywords
      (method_keyword_language
        (rhs) @_lang))
    (external_method_body_content) @injection.content))
  (#set! injection.include-children "true")
  (#match? @_lang "^[Tt][Ss][Qq][Ll]$")
  (#set! injection.language "tsql"))

(query
  (return_type
    (typename
      (identifier) @_querytype
      (#match? @_querytype "^%[Ss][Qq][Ll][Qq][Uu][Ee][Rr][Yy]$")))
  (query_body
    (query_body_content) @injection.content)
  (#set! injection.language "sql")
  (#set! injection.include-children "true"))

(xdata
  (xdata_any
    (xdata_keywords
      (xdata_keyword_mimetype
        (rhs) @_mt))
    (external_method_body_content) @injection.content)
  (#set! injection.include-children "true")
  (#match? @_mt "^\"?text/markdown\"?$")
  (#set! injection.language "markdown"))

(xdata
  (xdata_any
    (xdata_keywords
      (xdata_keyword_mimetype
        (rhs) @_mt))
    (external_method_body_content) @injection.content)
  (#set! injection.include-children "true")
  (#match? @_mt
    "^\"?([Tt][Ee][Xx][Tt]|[Aa][Pp][Pp][Ll][Ii][Cc][Aa][Tt][Ii][Oo][Nn])/[Xx][Mm][Ll]\"?$")
  (#set! injection.language "xml"))

(xdata
  (xdata_any
    (xdata_keywords
      (xdata_keyword_mimetype
        (rhs) @_mt))
    (external_method_body_content) @injection.content)
  (#set! injection.include-children "true")
  (#match? @_mt "^\"?text/html\"?$")
  (#set! injection.language "html"))

(xdata
  (xdata_any
    (xdata_keywords
      (xdata_keyword_mimetype
        (rhs) @_mt))
    (external_method_body_content) @injection.content)
  (#set! injection.include-children "true")
  (#match? @_mt "^\"?application/json\"?$")
  (#set! injection.language "json"))

(xdata
  (xdata_any
    (xdata_keywords
      (xdata_keyword_mimetype
        (rhs) @_mt))
    (external_method_body_content) @injection.content)
  (#set! injection.include-children "true")
  (#match? @_mt
    "^\"?([Tt][Ee][Xx][Tt]|[Aa][Pp][Pp][Ll][Ii][Cc][Aa][Tt][Ii][Oo][Nn])/[Yy][Aa][Mm][Ll]\"?$")
  (#set! injection.language "yaml"))

(xdata
  (xdata_any
    (xdata_keywords
      (xdata_keyword_mimetype
        (rhs) @_mt))
    (external_method_body_content) @injection.content)
  (#set! injection.include-children "true")
  (#match? @_mt "^\"?text/css\"?$")
  (#set! injection.language "css"))

(xdata
  (xdata_xml
    (xdata_keywords)?
    (external_method_body_content) @injection.content)
  (#set! injection.include-children "true")
  (#set! injection.language "xml"))

(storage
  (storage_body
    (external_method_body_content) @injection.content)
  (#set! injection.language "xml")
  (#set! injection.include-children "true"))
