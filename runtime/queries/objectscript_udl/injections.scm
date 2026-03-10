; Core grammar injections
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

; UDL grammar injections
; Keywords, one of type language = "python", none of type codemode
; External method body injection based on [ Language = ... ]
(method_definition
  (external_method_keywords
    (method_keyword_language
      (rhs) @_lang))
  (external_method_body_content) @injection.content
  (#set! injection.include-children)
  (#match? @_lang "^[Pp][Yy][Tt][Hh][Oo][Nn]$")
  (#set! injection.language "python"))

(method_definition
  (external_method_keywords
    (method_keyword_language
      (rhs) @_lang))
  (external_method_body_content) @injection.content
  (#set! injection.include-children)
  (#match? @_lang "^[Tt][Ss][Qq][Ll]$")
  (#set! injection.language "tsql"))

(method_definition
  (external_method_keywords
    (method_keyword_language
      (rhs) @_lang))
  (external_method_body_content) @injection.content
  (#set! injection.include-children)
  (#match? @_lang "^[Ii][Ss][Pp][Ll]$")
  (#set! injection.language "ispl"))

; External trigger with python body
((trigger
  (external_trigger
    (trigger_keywords
      (method_keyword_language
        (rhs) @_lang))
    (external_method_body_content) @injection.content))
  (#set! injection.include-children)
  (#match? @_lang "^[Pp][Yy][Tt][Hh][Oo][Nn]$")
  (#set! injection.language "python"))

; External trigger with TSQL body
((trigger
  (external_trigger
    (trigger_keywords
      (method_keyword_language
        (rhs) @_lang))
    (external_method_body_content) @injection.content))
  (#set! injection.include-children)
  (#match? @_lang "^[Tt][Ss][Qq][Ll]$")
  (#set! injection.language "tsql"))

; A query must be of type %SQLQuery to have an SQL body, otherwise the body
; is empty
(query
  (return_type
    (typename
      (identifier) @_querytype
      (#match? @_querytype "^%[Ss][Qq][Ll][Qq][Uu][Ee][Rr][Yy]$")))
  (query_body
    (query_body_content) @injection.content)
  (#set! injection.language "sql")
  (#set! injection.include-children))

; XDATA blocks:
; - xdata_any requires a keyword list that includes MimeType
; - xdata_xml allows an optional keyword list and defaults to XML
; ----------------------------
; XDATA injections (MimeType)
; ----------------------------
; text/markdown
(xdata
  (xdata_any
    (xdata_keywords
      (xdata_keyword_mimetype
        (rhs) @_mt))
    (external_method_body_content) @injection.content)
  (#set! injection.include-children)
  (#match? @_mt "^\"?text/markdown\"?$")
  (#set! injection.language "markdown"))

; XML MimeTypes
(xdata
  (xdata_any
    (xdata_keywords
      (xdata_keyword_mimetype
        (rhs) @_mt))
    (external_method_body_content) @injection.content)
  (#set! injection.include-children)
  (#match? @_mt
    "^\"?([Tt][Ee][Xx][Tt]|[Aa][Pp][Pp][Ll][Ii][Cc][Aa][Tt][Ii][Oo][Nn])/[Xx][Mm][Ll]\"?$")
  (#set! injection.language "xml"))

; text/html
(xdata
  (xdata_any
    (xdata_keywords
      (xdata_keyword_mimetype
        (rhs) @_mt))
    (external_method_body_content) @injection.content)
  (#set! injection.include-children)
  (#match? @_mt "^\"?text/html\"?$")
  (#set! injection.language "html"))

; application/json
(xdata
  (xdata_any
    (xdata_keywords
      (xdata_keyword_mimetype
        (rhs) @_mt))
    (external_method_body_content) @injection.content)
  (#set! injection.include-children)
  (#match? @_mt "^\"?application/json\"?$")
  (#set! injection.language "json"))

; text/yaml or application/yaml
(xdata
  (xdata_any
    (xdata_keywords
      (xdata_keyword_mimetype
        (rhs) @_mt))
    (external_method_body_content) @injection.content)
  (#set! injection.include-children)
  (#match? @_mt
    "^\"?([Tt][Ee][Xx][Tt]|[Aa][Pp][Pp][Ll][Ii][Cc][Aa][Tt][Ii][Oo][Nn])/[Yy][Aa][Mm][Ll]\"?$")
  (#set! injection.language "yaml"))

; text/css
(xdata
  (xdata_any
    (xdata_keywords
      (xdata_keyword_mimetype
        (rhs) @_mt))
    (external_method_body_content) @injection.content)
  (#set! injection.include-children)
  (#match? @_mt "^\"?text/css\"?$")
  (#set! injection.language "css"))

; -----------------------------------------
; XDATA default (no MimeType): XML fallback
; -----------------------------------------
(xdata
  (xdata_xml
    (xdata_keywords)?
    (external_method_body_content) @injection.content)
  (#set! injection.include-children)
  (#set! injection.language "xml"))

; Storage definition is XML
(storage
  (storage_body
    (external_method_body_content) @injection.content)
  (#set! injection.language "xml")
  (#set! injection.include-children))
