((template_content) @injection.content
  (#set! injection.language "html")
  (#set! injection.combined))

; TODO we can switch to quantifiers once neovim 0.10 becomes stable
(javascript_statement
  (js_content) @injection.content
  (#set! injection.language "javascript")
  (#set! injection.combined))

(schema_statement
  (json_content) @injection.content
  (#set! injection.language "json")
  (#set! injection.combined))

(style_statement
  (style_content) @injection.content
  (#set! injection.language "css")
  (#set! injection.combined))

((front_matter) @injection.content
  (#set! injection.language "yaml")
  (#offset! @injection.content 1 0 -1 0)
  (#set! injection.include-children))

((comment) @injection.content
  (#set! injection.language "comment"))
