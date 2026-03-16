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
  (#any-of? @_lang "python" "Python" "PYTHON")
  (#set! injection.language "python"))

(method_definition
  (external_method_keywords
    (method_keyword_language
      (rhs) @_lang))
  (external_method_body_content) @injection.content
  (#set! injection.include-children "true")
  (#any-of? @_lang "tsql" "TSQL" "tSQL" "tSql" "TSql")
  (#set! injection.language "tsql"))

(method_definition
  (external_method_keywords
    (method_keyword_language
      (rhs) @_lang))
  (external_method_body_content) @injection.content
  (#set! injection.include-children "true")
  (#any-of? @_lang "ispl" "ISPL" "ISpl" "iSpl")
  (#set! injection.language "ispl"))

((trigger
  (external_trigger
    (trigger_keywords
      (method_keyword_language
        (rhs) @_lang))
    (external_method_body_content) @injection.content))
  (#set! injection.include-children "true")
  (#any-of? @_lang "python" "Python" "PYTHON")
  (#set! injection.language "python"))

((trigger
  (external_trigger
    (trigger_keywords
      (method_keyword_language
        (rhs) @_lang))
    (external_method_body_content) @injection.content))
  (#set! injection.include-children "true")
  (#any-of? @_lang "tsql" "TSQL" "tSQL" "tSql" "TSql")
  (#set! injection.language "tsql"))

(query
  (return_type
    (typename
      (identifier) @_querytype
      (#any-of? @_querytype "%SqlQuery" "%sqlquery" "%SQLQUERY" "%Sqlquery" "%SQLQuery")))
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
  (#any-of? @_mt "text/markdown" "\"text/markdown\"")
  (#set! injection.language "markdown"))

(xdata
  (xdata_any
    (xdata_keywords
      (xdata_keyword_mimetype
        (rhs) @_mt))
    (external_method_body_content) @injection.content)
  (#set! injection.include-children "true")
  (#any-of? @_mt "text/xml" "\"text/xml\"" "application/xml" "\"application/xml\"")
  (#set! injection.language "xml"))

(xdata
  (xdata_any
    (xdata_keywords
      (xdata_keyword_mimetype
        (rhs) @_mt))
    (external_method_body_content) @injection.content)
  (#set! injection.include-children "true")
  (#any-of? @_mt "text/html" "\"text/html\"")
  (#set! injection.language "html"))

(xdata
  (xdata_any
    (xdata_keywords
      (xdata_keyword_mimetype
        (rhs) @_mt))
    (external_method_body_content) @injection.content)
  (#set! injection.include-children "true")
  (#any-of? @_mt "application/json" "\"application/json\"")
  (#set! injection.language "json"))

(xdata
  (xdata_any
    (xdata_keywords
      (xdata_keyword_mimetype
        (rhs) @_mt))
    (external_method_body_content) @injection.content)
  (#set! injection.include-children "true")
  (#any-of? @_mt "text/yaml" "\"text/yaml\"" "application/yaml" "\"application/yaml\"")
  (#set! injection.language "yaml"))

(xdata
  (xdata_any
    (xdata_keywords
      (xdata_keyword_mimetype
        (rhs) @_mt))
    (external_method_body_content) @injection.content)
  (#set! injection.include-children "true")
  (#any-of? @_mt "text/css" "\"text/css\"")
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

