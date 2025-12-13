; Target method_body_content and reparse it using
; objectscript_core
(embedded_html
  (angled_bracket_fenced_text) @injection.content
  (#set! injection.language "html")
  (#set! injection.include-children "false")
  (#set! injection.combined "true"))

(embedded_sql
  (_
    (paren_fenced_text) @injection.content)
  (#set! injection.language "sql")
  (#set! injection.include-children "false")
  (#set! injection.combined "true"))

(embedded_js
  (angled_bracket_fenced_text) @injection.content
  (#set! injection.language "javascript")
  (#set! injection.include-children "false")
  (#set! injection.combined "true"))

(embedded_xml
  (angled_bracket_fenced_text) @injection.content
  (#set! injection.language "xml")
  (#set! injection.include-children "false")
  (#set! injection.combined "true"))

([
  (line_comment_1)
  (line_comment_2)
  (line_comment_3)
  (block_comment)
  (documatic_line)
] @injection.content
  (#set! injection.language "comment"))

; Keywords, one of type language = "python", none of type codemode
(method_definition
  keywords: (_
    (kw_External_Language
      rhs: _ @injection.language))
  body: (_) @injection.content
  (#set! injection.include-children "true"))

(trigger
  keywords: (_
    (kw_External_Language
      rhs: _ @injection.language))
  body: (_) @injection.content
  (#set! injection.include-children "true"))

; A query must be of type %SQLQuery to have an SQL body, otherwise the body
; is empty
(query
  type: (_
    (typename
      (identifier) @_querytype
      (#eq? @_querytype "%SQLQuery")))
  (_
    (query_body_content) @injection.content)
  (#set! injection.language "sql")
  (#set! injection.include-children "true"))

; XDATA blocks.  There's a MimeType keyword that defines the content-type
; To prevent overlapping matches, we use a different body for the case where
; no MimeType is given and default to XML, otherwise we extract the language
; from the mimetype.
(xdata
  keywords: (_
    (kw_MimeType
      rhs: _ @_mimetype
      (#eq? @_mimetype "\"text/markdown\"")))
  body: (xdata_body_content_any) @injection.content
  (#set! injection.language "markdown")
  (#set! injection.include-children "true"))

(xdata
  keywords: (_
    (kw_MimeType
      rhs: _ @_mimetype
      (#eq? @_mimetype "\"text/xml\"")))
  ; NOTE: Since MimeType is given, we match xdata_body_content_any not xml
  body: (xdata_body_content_any) @injection.content
  (#set! injection.language "xml")
  (#set! injection.include-children "true"))

(xdata
  keywords: (_
    (kw_MimeType
      rhs: _ @_mimetype
      (#eq? @_mimetype "\"text/html\"")))
  body: (xdata_body_content_any) @injection.content
  (#set! injection.language "html")
  (#set! injection.include-children "true"))

(xdata
  keywords: (_
    (kw_MimeType
      rhs: _ @_mimetype
      (#eq? @_mimetype "\"application/json\"")))
  body: (xdata_body_content_any) @injection.content
  (#set! injection.language "json")
  (#set! injection.include-children "true"))

(xdata
  keywords: (_
    (kw_MimeType
      rhs: _ @_mimetype
      (#eq? @_mimetype "\"text/css\"")))
  body: (xdata_body_content_any) @injection.content
  (#set! injection.language "css")
  (#set! injection.include-children "true"))

; Match an unspecified XDATA -- defaults to XML
(xdata
  body: (xdata_body_content_xml) @injection.content
  (#set! injection.language "xml")
  (#set! injection.include-children "true"))

; Storage definition is XML
(storage
  body: (_) @injection.content
  (#set! injection.language "xml")
  (#set! injection.include-children "true"))
